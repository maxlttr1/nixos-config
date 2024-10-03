{ config, pkgs, callPackage, ... }:

{
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
  };
  services.displayManager.defaultSession = "xfce";

  xdg.portal.extraPortals = [ "xdg-desktop-portal-kde" ];

  xdg.portal.enable = true;

}
