{ pkgs, ... }:

{
  # Flatpaks
  services.flatpak.packages = [
    "com.jeffser.Alpaca"
    "co.logonoff.awakeonlan"
    "com.usebottles.bottles"
    "org.gnome.DejaDup"
    "com.discordapp.Discord"
    "org.kde.filelight"
    "com.github.tchx84.Flatseal"
    "nl.hjdskes.gcolor3"
    "io.github.shiftey.Desktop"
    "org.kde.isoimagewriter"
    "org.kde.kleopatra"
    "org.kde.kweather"
    "org.libreoffice.LibreOffice"
    "io.gitlab.librewolf-community"
    "org.gnome.World.PikaBackup"
    "com.github.marhkb.Pods"
    "me.proton.Pass"
    "com.protonvpn.www"
    "org.signal.Signal"
    "me.kozec.syncthingtk"
    "com.visualstudio.code"
    "org.kde.yakuake"
  ];

  environment.systemPackages = with pkgs; [
    curl
    fastfetch
    git
    jdk #Java LTS
    python312
    python312Packages.pip
    python312Packages.pytest
    tree
    universal-android-debloater
    unzip
    wget
  ];
  
  # Open ports in the firewall for kde connect
  networking.firewall = rec {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };
 
  services.flatpak = {
    enable = true;
    update = {
      auto = {
        enable = true;
        onCalendar = "daily";
      };
    };
  };


}
