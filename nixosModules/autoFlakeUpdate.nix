{ lib, config, pkgs, settings, ... }:

let
  githubTokenPath = "/home/${settings.username}/.cache/sops-nix/secrets/github-token";
  webhookPath = "/home/${settings.username}/.cache/sops-nix/secrets/discord-webhook";
in

{
  options = {
    custom.autoFlakeUpdate.enable = lib.mkEnableOption "Enable automatic NixOS flake input updates";
    custom.autoFlakeUpdate.frequency = lib.mkOption {
      description = "Frequency of automatic flake input updates";
      default = "weekly";
      type = lib.types.enum [ "daily" "weekly" "monthly" "yearly" ];
    };
  };

  config = lib.mkIf config.custom.autoFlakeUpdate.enable {
    systemd.services."nixos-flake-update" = {
      description = "Update NixOS flake inputs";
      serviceConfig = {
        Type = "oneshot";
        User = "${settings.username}";
        WorkingDirectory = "/home/${settings.username}/";
      };
      script = ''
        set -euox pipefail

        if [ ! -f ${githubTokenPath} ]; then
          echo "GitHub token file not found at ${githubTokenPath}"
          exit 1
        fi
        githubToken=$(cat ${githubTokenPath})
        
        mkdir -p /home/${settings.username}/.cache/
        if [ ! -d /home/${settings.username}/.cache/nixos-config ]; then
          ${pkgs.git}/bin/git clone https://$githubToken@github.com/maxlttr1/nixos-config.git /home/${settings.username}/.cache/nixos-config
        else
          echo "Flake input directory already exists. Skipping clone."
        fi

        cd /home/${settings.username}/.cache/nixos-config
        ${pkgs.git}/bin/git reset --hard origin/master
        ${pkgs.git}/bin/git fetch origin
        ${pkgs.git}/bin/git checkout master
        ${pkgs.git}/bin/git pull origin master

        if ! ${pkgs.nix}/bin/nix flake update; then
          echo "Flake update failed"
          exit 1
        fi

        if ! ${pkgs.nix}/bin/nix flake check; then
          echo "Flake check failed"
          exit 1
        fi

        for hostname in "nexus-nexus" "terra-terra"; do
          if ! ${pkgs.nixos-rebuild}/bin/nixos-rebuild build --flake .#$hostname; then
            echo "Nixos-rebuild build failed for $hostname"
            exit 1
          fi
        done

        DATE=$(date +'%Y-%m-%d')
        BRANCH="flake-auto-update-$DATE"
        echo "Generated branch: $BRANCH"
        ${pkgs.git}/bin/git checkout -B "$BRANCH"
        ${pkgs.git}/bin/git add flake.lock
        ${pkgs.git}/bin/git commit -m "Update flake.lock" || true
        ${pkgs.git}/bin/git push origin "$BRANCH"
    
        ${pkgs.curl}/bin/curl -L \
          -X POST \
          -H "Accept: application/vnd.github+json" \
          -H "Authorization: Bearer $githubToken" \
          -H "X-GitHub-Api-Version: 2022-11-28" \
          https://api.github.com/repos/maxlttr1/nixos-config/pulls \
          -d "{
            \"title\": \"Update to flake.lock on $DATE\",
            \"body\": \"Please test it locally and merge the PR: sudo -E nixos-rebuild build-vm --flake github:maxlttr1/nixos-config?ref=$BRANCH or sudo nixos-rebuild test --flake github:maxlttr1/nixos-config?ref=$BRANCH\",
            \"head\": \"$BRANCH\",
            \"base\": \"master\"
          }"

        if ${pkgs.git}/bin/git branch --list "$BRANCH" | grep -q .; then
          ${pkgs.git}/bin/git switch master
          ${pkgs.git}/bin/git branch -D "$BRANCH"
        fi
      '';
      postStop = ''
        url=$(cat ${webhookPath})
        status=$(systemctl show nixos-flake-update.service -p ExecMainStatus --value)

        if [ $status -eq 0 ]; then
          ${pkgs.curl}/bin/curl -X POST "$url" -H "Content-Type: application/json" -d "{\"content\": \"✅ Nix flake.lock updated and passed check.\"}"
        else
          payload="❌ Nix flake update failed."          
          ${pkgs.curl}/bin/curl -X POST "$url" -H "Content-Type: application/json" -d "{\"content\": \"❌ Nix flake update failed (will retry tomorrow).\"}"
        fi
      '';
    };

    systemd.timers."nixos-flake-update" = {
      wantedBy = [ "multi-user.target" ];
      timerConfig = {
        OnCalendar = "${config.custom.autoFlakeUpdate.frequency}";
        Persistent = true;
      };
    };
  };
}