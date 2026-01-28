{ config, lib, pkgs, ... }:

{
  options.xdgCustom.enable = lib.mkEnableOption "XDG base directory configuration";

  config = lib.mkIf config.xdgCustom.enable {
    xdg.autostart = {
      enable = true;
      entries = [
        "${pkgs.kdePackages.yakuake}/share/applications/org.kde.yakuake.desktop"
      ];
      #readOnly = true;
    };
  };
}
