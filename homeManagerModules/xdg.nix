{ config, lib, pkgs, settings, ... }:

{
  options.xdgCustom.enable = lib.mkEnableOption "XDG base directory configuration";

  config = lib.mkIf config.xdgCustom.enable {
    xdg.autostart = {
      enable = true;
      entries = [
        "${pkgs.kdePackages.yakuake}/share/applications/org.kde.yakuake.desktop"
        "/home/${settings.username}/.local/share/flatpak/exports/share/applications/dev.vencord.Vesktop.desktop"
      ];
      #readOnly = true;
    };
  };
}
