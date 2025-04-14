{ pkgs, lib, ... }:

{
  # Flatpaks
  services.flatpak.packages = [
    #"co.logonoff.awakeonlan"
    "com.google.Chrome"
    "io.github.lainsce.Colorway"
    "org.kde.filelight"
    "com.github.tchx84.Flatseal"
    "io.github.milkshiift.GoofCord"
    "io.github.finefindus.Hieroglyphic"
    "dev.bragefuglseth.Keypunch"
    "org.kde.konsole"
    "io.gitlab.librewolf-community"
    "io.github.mhogomchungu.media-downloader"
    "md.obsidian.Obsidian"
    "io.github.nate_xyz.Paleta"
    "com.protonvpn.www"
    "org.torproject.torbrowser-launcher"
    "org.videolan.VLC"
    "org.kde.yakuake"
  ];

  environment.defaultPackages = lib.mkForce []; # Delete all default pkgs

  environment.systemPackages = 
    (with pkgs; [
      bibata-cursors
      cmake
      compose2nix
      gcc
      gnumake
      jdk
      jetbrains-mono
      nodejs
      python313Full
      papirus-icon-theme
      rstudio
      sops
      veracrypt
    ])
    ++
    (with pkgs.unstable; [
    ]);

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
