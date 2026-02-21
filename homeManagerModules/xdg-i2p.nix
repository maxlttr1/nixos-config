{ config, lib, pkgs, ... }:

{
  options.custom.xdg-i2p.enable = lib.mkEnableOption "Enable i2p browser desktop entry and profile";

  config = lib.mkIf config.custom.xdg-i2p.enable {
    xdg.desktopEntries = {
      i2p-browser = {
        name = "i2p Browser";
        genericName = "Web Browser";
        exec = "${pkgs.librewolf}/bin/librewolf";
        icon = "librewolf";
      };
    };
  };
}
