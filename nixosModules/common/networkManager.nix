{
  lib,
  config,
  settings,
  ...
}:

{
  options = {
    custom.networkManager.enable = lib.mkEnableOption "Enable NetworkManager";
  };

  config = lib.mkIf config.custom.networkManager.enable {
    networking.networkmanager = {
      enable = true;
      ethernet.macAddress = "stable";
      dns = "systemd-resolved";
      wifi = {
        macAddress = "stable-ssid";
        backend = "wpa_supplicant"; # Default
      };
      # logLevel = "DEBUG";
    };

    services.resolved = {
      enable = true;
      settings.Resolve = {
        DNS = [
          "1.1.1.1#one.one.one.one"
          "8.8.8.8#dns.google"
        ];
        DNSOverTLS = "opportunistic";
        DNSSEC = "allow-downgrade";
      };
    };

    users.users."${settings.username}".extraGroups = [ "networkmanager" ];
  };
}
