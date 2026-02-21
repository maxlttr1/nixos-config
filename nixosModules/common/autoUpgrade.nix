{ lib, config, pkgs, settings, ... }:

let
  notifyScript = pkgs.writeShellScript "notify-discord" ''
    
    url=$(cat /home/${settings.username}/.config/sops-nix/secrets/discord-webhook)
    hostname=$(${pkgs.nettools}/bin/hostname)
    status=$(systemctl show nixos-upgrade.service -p ExecMainStatus --value)

    if [ $status -eq 0 ]; then
      ${pkgs.curl}/bin/curl -X POST "$url" \
        -H "Content-Type: application/json" \
        -d "{\"content\": \"✅ NixOS upgrade successful on **$hostname**\"}"
    else
      ${pkgs.curl}/bin/curl -X POST "$url" \
        -H "Content-Type: application/json" \
        -d "{\"content\": \"❌ NixOS upgrade failed on **$hostname**\"}"
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
      operation = "switch"; # Or "boot"
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
      serviceConfig = {
        ExecStart = "${notifyScript}";
      };
    };
  };
}
