{ lib, config, pkgs, settings, ... }:

let
  webhookPath = "/home/${settings.username}/.cache/sops-nix/secrets/discord-webhook";
  webhookDir = "/home/${settings.username}/.cache/sops-nix/secrets/";
  notifyScript = pkgs.writeShellScript "notify-discord" ''
    
    url=$(cat ${webhookPath})
    status=$(systemctl show nixos-upgrade.service -p ExecMainStatus --value)

    if [ $status -eq 0 ]; then
      ${pkgs.curl}/bin/curl -X POST "$url" \
        -H "Content-Type: application/json" \
        -d "{\"content\": \"✅ NixOS upgrade successful on **${config.networking.hostName}**\"}"
    else
      ${pkgs.curl}/bin/curl -X POST "$url" \
        -H "Content-Type: application/json" \
        -d "{\"content\": \"❌ NixOS upgrade failed on **${config.networking.hostName}**\"}"
    fi
  '';
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
        "--refresh" # Force fresh fetch from GitHub
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
      onSuccess = [ "nixos-upgrade-notification.service" ];
      onFailure = [ "nixos-upgrade-notification.service" ];
    };

    systemd.services."nixos-upgrade-notification" = {
      description = "Send a notification nixos-upgrade.service ends";
      after = [ "sops-nix.service" ];
      serviceConfig = {
        ExecStart = "${notifyScript}";
        Type = "oneshot";
      };
    };

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
