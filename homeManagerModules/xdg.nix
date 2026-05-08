{
  config,
  lib,
  pkgs,
  settings,
  ...
}:

{
  options.custom.xdgCustom.enable = lib.mkEnableOption "XDG base directory configuration";

  config = lib.mkIf config.custom.xdgCustom.enable {
    xdg.autostart = {
      enable = true;
      entries =
        [ ]
        ++ lib.optionals (config.custom.pkgs.enable) [
          "${pkgs.signal-desktop}/share/applications/signal.desktop"
          "/home/${settings.username}/.local/share/flatpak/exports/share/applications/dev.vencord.Vesktop.desktop"
        ]
        ++ lib.optionals (config.custom.yakuake.enable) [
          "${pkgs.kdePackages.yakuake}/share/applications/org.kde.yakuake.desktop"
        ];
      # readOnly = true;
    };
  };
}
