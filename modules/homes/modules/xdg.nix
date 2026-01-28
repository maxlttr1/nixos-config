{ pkgs, ... }:

{
  xdg.autostart = {
    enable = true;
    entries = [
      "${pkgs.discord}/share/applications/discord.desktop"
      "${pkgs.kdePackages.yakuake}/share/applications/org.kde.yakuake.desktop"
    ];
    #readOnly = true;
  };
}
