{
  services.xserver.enable = true;
  
  services.displayManager.defaultSession = "plasma";
  services.desktopManager.plasma6.enable = true;

  #services.displayManager.sddm.wayland.enable = true;
  #services.displayManager.sddm.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;

  programs.kdeconnect.enable = true;
}
