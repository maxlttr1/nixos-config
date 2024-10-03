{ pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ "xdg-desktop-portal-kde" ];
}

