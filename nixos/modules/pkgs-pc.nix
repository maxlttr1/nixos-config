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
    "org.kde.kweather"
    "org.libreoffice.LibreOffice"
    "io.gitlab.librewolf-community"
    "org.gnome.World.PikaBackup"
    "com.github.marhkb.Pods"
    "com.protonvpn.www"
    "org.signal.Signal"
    "me.kozec.syncthingtk"
    "com.visualstudio.code"
    "org.kde.yakuake"
  ];

  environment.systemPackages = with pkgs; [
    python312
    python312Packages.pip
    python312Packages.pytest
    universal-android-debloater
    unzip
  ];
  
  {
  # Open ports in the firewall for kde connect
  networking.firewall = rec {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };
}

}
