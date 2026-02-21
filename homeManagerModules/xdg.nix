{ config, lib, pkgs, settings, ... }:

{
  options.custom.xdgCustom.enable = lib.mkEnableOption "XDG base directory configuration";

  config = lib.mkIf config.custom.xdgCustom.enable {
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
