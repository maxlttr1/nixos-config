{ pkgs, ... }:

{
  # Flatpaks
  services.flatpak.packages = [
    "com.jeffser.Alpaca"
    "co.logonoff.awakeonlan"
    "org.kde.cantor"
    "com.bitwarden.desktop"
    "org.gnome.DejaDup"
    "com.discordapp.Discord"
    "org.kde.filelight"
    "com.github.tchx84.Flatseal"
    "nl.hjdskes.gcolor3"
    "io.github.shiftey.Desktop"
    "org.kde.isoimagewriter"
    "org.kde.kalgebra"
    "org.kde.kdenlive"
    "org.kde.kleopatra"
    "org.kde.kontact"
    "org.libreoffice.LibreOffice"
    "io.gitlab.librewolf-community"
    "org.gnome.World.PikaBackup"
    "com.github.marhkb.Pods"
    "com.protonvpn.www"
    "org.signal.Signal"
    "me.kozec.syncthingtk"
    "com.vscodium.codium"
    "org.kde.yakuake"
  ];

environment.systemPackages = with pkgs; [
  gnomeExtensions.gsconnect
  python312
  python312Packages.pip
  python312Packages.pytest
  universal-android-debloater
  ];
}
