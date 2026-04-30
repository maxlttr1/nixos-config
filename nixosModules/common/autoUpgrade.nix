{ lib, config, pkgs, settings, ... }:

let
  webhookPath = "/home/${settings.username}/.cache/sops-nix/secrets/discord-webhook";
  webhookDir = "/home/${settings.username}/.cache/sops-nix/secrets/";
in

{
  options = {
    custom.autoUpgrade.enable = lib.mkEnableOption "Enable automatic NixOS upgrades";
    custom.autoUpgrade.frequency = lib.mkOption {
      description = "AutoUpgrade frequency";
      default = "02:00";
      type = lib.types.enum [ "02:00" "daily" "weekly" "monthly" "yearly" ];
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
        cd /tmp
        ${pkgs.nixos-rebuild}/bin/nixos-rebuild build --flake github:maxlttr1/nixos-config
        ${pkgs.nix}/bin/nix store diff-closures /var/run/current-system ./result > /tmp/nixos-upgrade-changes.txt
        rm -r ./result
      '';
      postStop = ''
        url=$(cat ${webhookPath})
        status=$(systemctl show nixos-upgrade.service -p ExecMainStatus --value)

        if [ $status -eq 0 ]; then
          changes=$(cat /tmp/nixos-upgrade-changes.txt)
          total=$(echo "$changes" | wc -l)
          summary=$(echo "$changes" | sed 's/\x1b\[[0-9;]*m//g' | grep -e plasma -e kde -e kernel | head -c 1900)
          
          payload=$(${pkgs.jq}/bin/jq -n --arg msg "✅ NixOS upgrade successful on **${config.networking.hostName}**: *$total packages changed*
          **Summary** \`\`\`$summary
          \`\`\`" '{content: $msg}')
          
          ${pkgs.curl}/bin/curl -X POST "$url" -H "Content-Type: application/json" -d "$payload"
        else
          error_log=$(journalctl -u nixos-upgrade.service -n 50 --no-pager | tail -c 1900)
          
          payload=$(${pkgs.jq}/bin/jq -n --arg msg "❌ NixOS upgrade failed on **${config.networking.hostName}**
          **Error log:** \`\`\`$error_log\`\`\`" '{content: $msg}')

          ${pkgs.curl}/bin/curl -X POST "$url" -H "Content-Type: application/json" -d "$payload"
        fi
      '';
    };


    /*
    payload=$(${pkgs.jq}/bin/jq -n --arg msg "# Titre\n$error_log" '{
            title: "Markdown Example",
            message: $msg,
            priority: 5,
            extras: {
              "client::display": {
                contentType: "text/markdown"
              }
            }
          }')
          curl "https://nexus-nexus/message?token=A." \
            -H "Content-Type: application/json" \
            -d "$payload"
    */

    systemd.user.services."copy-discord-webhook" = {
      description = "Copy Discord webhook secret to user home directory";
      serviceConfig = {
        Type = "oneshot";
      };
      script = ''
        mkdir -p ${webhookDir}
        cp /home/${settings.username}/.config/sops-nix/secrets/discord-webhook ${webhookPath}
      '';
      after = [ "sops-nix.service" ];
      wantedBy = [ "sops-nix.service" ];
    };
  };
}
