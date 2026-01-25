{ settings, ... }:

{
  networking.networkmanager = {
    enable = true;
    #ethernet.macAddress = "random"; #  Generate a randomized value upon each connect
    dns = "systemd-resolved";
    wifi = {
      macAddress = "stable-ssid"; # Generate a stable MAC addressed based on Wi-Fi network
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

  users.users.${settings.username}.extraGroups = [ "networkmanager" ];
}
