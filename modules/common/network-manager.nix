{ settings, ... }:

{
  networking.networkmanager = {
    enable = true;
    #ethernet.macAddress = "random"; #  Generate a randomized value upon each connect
    wifi = {
      macAddress = "stable-ssid"; # Generate a stable MAC addressed based on Wi-Fi network
      backend = "wpa_supplicant"; # Default
    };
    logLevel = "DEBUG";
  };

  users.users.${settings.username}.extraGroups = [ "networkmanager" ];
}
