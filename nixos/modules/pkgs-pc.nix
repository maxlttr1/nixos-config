{ pkgs, ... }:

{
  # Flatpaks
  services.flatpak.packages = [
    "com.jeffser.Alpaca"
    "co.logonoff.awakeonlan"
    "com.bitwarden.desktop"
    "org.gnome.DejaDup"
    "com.discordapp.Discord"
    "com.github.tchx84.Flatseal"
    "nl.hjdskes.gcolor3"
    "io.github.shiftey.Desktop"
    "org.gnupg.GPA"
    "org.libreoffice.LibreOffice"
    "io.gitlab.librewolf-community"
    "md.obsidian.Obsidian"
    "com.github.marhkb.Pods"
    "com.protonvpn.www"
    "org.signal.Signal"
    "me.kozec.syncthingtk"
    "com.vscodium.codium"
  ];

environment.systemPackages = with pkgs; [
  python312
  python312Packages.pip
  python312Packages.pytest
  ];


};
