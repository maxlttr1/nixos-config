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
      ethernet.macAddress = "preserve";
      dns = "systemd-resolved";
      wifi = {
        macAddress = "stable-ssid";
        backend = "wpa_supplicant"; # Default
        scanRandMacAddress = true;
      };
      # logLevel = "DEBUG";
    };

    services.resolved = {
      enable = true;
      settings.Resolve = {
        DNS = [
          "194.242.2.4#base.dns.mullvad.net"
          "9.9.9.9#dns.quad9.net"
          # "1.1.1.1#one.one.one.one"
          # "8.8.8.8#dns.google"
        ];
        DNSOverTLS = "opportunistic";
        DNSSEC = "allow-downgrade";
      };
    };

    users.users."${settings.username}".extraGroups = [ "networkmanager" ];
  };
}
