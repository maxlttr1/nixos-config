{ lib, config, settings, ... }:

{
  options = {
    networkManager.enable = lib.mkEnableOption "Enable NetworkManager";
  };

  config = lib.mkIf config.networkManager.enable {
    networking.networkmanager = {
      enable = true;
      ethernet.macAddress = "random";
      dns = "systemd-resolved";
      wifi = {
        macAddress = "random";
        backend = "wpa_supplicant"; # Default
      };
      logLevel = "DEBUG";
    };

    services.resolved = {
      enable = true;
      dnsovertls = "opportunistic";
      dnssec = "allow-downgrade";
      fallbackDns = [ "9.9.9.9" "1.1.1.1" "8.8.8.8" ];
    };

    users.users."${settings.username}".extraGroups = [ "networkmanager" ];
  };
}
