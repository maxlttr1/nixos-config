{ pkgs, ... }:

{
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.autoNumlock = true;
  services.displayManager.sddm.wayland.enable = true; # Launch sddm in Wayland too (try to avoid running an X server)
  services.displayManager.defaultSession = "plasma"; # plasma or plasmax11

  programs.kdeconnect.enable = true;

  # Open ports in the firewall for kde connect
  networking.firewall = rec {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };
  
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    #discover
    elisa
    kate
    khelpcenter
    #konsole
  ];
}
