{
  services.xserver.enable = true;
  
  services.displayManager.defaultSession = "plasma";
  services.desktopManager.plasma6.enable = true;

  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.enable = true;

  programs.kdeconnect.enable = true;

  # Open ports in the firewall for kde connect
  networking.firewall = rec {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };
}
