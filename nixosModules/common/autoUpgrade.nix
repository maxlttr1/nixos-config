{ lib, config, pkgs, ... }:

let
  notifyScript = pkgs.writeShellScript "notify-discord" ''
    
    url=$(cat /home/${config.users.mainUsername}/.config/sops-nix/secrets/discord-webhook)
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
  
  baseConfig = {
    enable = true;
    flake = "github:maxlttr1/nixos-config";
    flags = [
      #"--update-input"
      #"nixpkgs-main"
      "-L" # Show logs
    ];
    dates = "daily";
    persistent = true;
    operation = "switch"; # Or "boot"
    allowReboot = true;
    rebootWindow = {
      lower = "01:00";
      upper = "05:00";
    };
  };
in

{
  options = {
    autoUpgrade.enable = lib.mkEnableOption "Enable automatic NixOS upgrades";
  };

  config = lib.mkIf config.autoUpgrade.enable {
    system.autoUpgrade = baseConfig;

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
