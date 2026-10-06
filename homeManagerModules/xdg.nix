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
      entries = [
        (pkgs.writeText "tailscale-systray.desktop" ''
          [Desktop Entry]
          Type=Application
          Name=Tailscale Systray
          Exec=${pkgs.tailscale}/bin/tailscale systray
          Terminal=false
          X-KDE-autostart-after=panel
        '')
        (pkgs.writeText "tailscale-reset-exit-node.desktop" ''
          [Desktop Entry]
          Type=Application
          Name=Tailscale Reset Exit Node
          Exec=${pkgs.tailscale}/bin/tailscale set --exit-node=
          Terminal=false
        '')
      ]
      ++ lib.optionals (config.custom.pkgs.enable) [
        "${pkgs.signal-desktop}/share/applications/signal.desktop"
        # "${pkgs.element-desktop}/share/applications/element-desktop.desktop"
        "/home/${settings.username}/.local/share/flatpak/exports/share/applications/dev.vencord.Vesktop.desktop"
      ]
      ++ lib.optionals (config.custom.yakuake.enable) [
        "${pkgs.kdePackages.yakuake}/share/applications/org.kde.yakuake.desktop"
      ];
      # readOnly = true;
    };
  };
}
