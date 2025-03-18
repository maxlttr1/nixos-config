{ pkgs, lib, ... }:

let
    lock-false = {
      Value = false;
      Status = "locked";
    };
    lock-true = {
      Value = true;
      Status = "locked";
    };
in

{
  # Flatpaks
  services.flatpak.packages = [
    #"co.logonoff.awakeonlan"
    "com.jetbrains.CLion"
    "me.iepure.devtoolbox"
    "org.kde.filelight"
    "com.github.tchx84.Flatseal"
    "io.github.milkshiift.GoofCord"
    "io.github.finefindus.Hieroglyphic"
    "dev.bragefuglseth.Keypunch"
    "org.kde.konsole"
    "io.github.mhogomchungu.media-downloader"
    "md.obsidian.Obsidian"
    "com.protonvpn.www"
    "org.torproject.torbrowser-launcher"
    "org.videolan.VLC"
    "org.kde.yakuake"
  ];

  environment.defaultPackages = lib.mkForce [];

  environment.systemPackages = 
    (with pkgs; [
      bibata-cursors
      gcc
      jetbrains-mono
      papirus-icon-theme
      veracrypt
      vscodium
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

  programs.firefox = {
    enable = true;
  };
}
