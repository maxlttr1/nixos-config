{
  lib,
  config,
  pkgs,
  settings,
  ...
}:

let
  githubTokenPath = "/home/${settings.username}/.cache/sops-nix/secrets/github-token";
  webhookPath = "/home/${settings.username}/.cache/sops-nix/secrets/discord-webhook";
  webhookDir = "/home/${settings.username}/.cache/sops-nix/secrets/";
in

{
  options = {
    custom.autoUpgrade.enable = lib.mkEnableOption "Enable automatic NixOS upgrades";
    custom.autoUpgrade.frequency = lib.mkOption {
      description = "AutoUpgrade frequency";
      default = "Sun 2:00";
      type = lib.types.enum [
        "02:00"
        "daily"
        "Sun 2:00"
        "weekly"
        "monthly"
        "yearly"
      ];
    };
  };

  config = lib.mkIf config.custom.autoUpgrade.enable {
    system.autoUpgrade = {
      enable = true;
      flake = "github:maxlttr1/nixos-config";
      flags = [
        #"--update-input"
        #"nixpkgs-main"
        "-L" # Show logs
        # "--refresh" # Force fresh fetch from GitHub
      ];
      dates = config.custom.autoUpgrade.frequency;
      persistent = true;
      operation = "switch";
      allowReboot = true;
      rebootWindow = {
        lower = "01:00";
        upper = "05:00";
      };
    };

    systemd.services."nixos-upgrade" = {
      preStart = ''
        set -euox pipefail

        cd /tmp
        rm -rf ./result
        if ! ${pkgs.nixos-rebuild}/bin/nixos-rebuild build --flake github:maxlttr1/nixos-config; then
          echo "Failed to build new system configuration"
          exit 1
        fi

        ${pkgs.nix}/bin/nix store diff-closures /var/run/current-system ./result > /tmp/nixos-upgrade-changes.txt
        rm -rf ./result
      '';
      postStop = ''
                set -euox pipefail

                url=$(cat ${webhookPath})
                status=$(systemctl show nixos-upgrade.service -p ExecMainStatus --value)

                if [ $status -eq 0 ] && [ -f /tmp/nixos-upgrade-changes.txt ]; then
                  changes=$(cat /tmp/nixos-upgrade-changes.txt)
                  total=$(echo "$changes" | grep -cve '^[[:space:]]*$')
                  summary=$(echo "$changes" | sed 's/\x1b\[[0-9;]*m//g' | grep -e plasma -e kde -e linux -e nixos | head -c 1900)

                  if [ -n "$summary" ]; then
                    msg="# ✅ NixOS upgrade successful on \`${config.networking.hostName}\`: *$total packages changed*
                    ## Summary:
        \`\`\`$summary\`\`\`"
                  else
                    msg="# ✅ NixOS upgrade successful on \`${config.networking.hostName}\`: *$total packages changed*"
                  fi
                else
                  error_log=$(journalctl -u nixos-upgrade.service -n 50 --no-pager | tail -c 1900)
                  msg="# ❌ NixOS upgrade failed on \`${config.networking.hostName}\`
                  ## Error log:
        \`\`\`$error_log\`\`\`"
                fi

                payload=$(${pkgs.jq}/bin/jq -n --arg msg "$msg" '{content: $msg}')
                ${pkgs.curl}/bin/curl -X POST "$url" -H "Content-Type: application/json" -d "$payload"
      '';
    };

    systemd.user.services."copy-discord-webhook" = {
      description = "Copy Discord webhook secret to user home directory";
      serviceConfig = {
        Type = "oneshot";
      };
      script = ''
        set -euox pipefail

        mkdir -p ${webhookDir}
        cp -f /home/${settings.username}/.config/sops-nix/secrets/github-token ${githubTokenPath}
        cp -f /home/${settings.username}/.config/sops-nix/secrets/discord-webhook ${webhookPath}
      '';
      after = [ "sops-nix.service" ];
      wantedBy = [ "sops-nix.service" ];
    };
  };
}
