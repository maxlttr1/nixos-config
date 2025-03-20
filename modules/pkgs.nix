{ pkgs, lib, ... }:

{
  # Flatpaks
  services.flatpak.packages = [
    #"co.logonoff.awakeonlan"
    "dev.qwery.AddWater"
    "me.iepure.devtoolbox"
    "org.kde.filelight"
    "com.github.tchx84.Flatseal"
    "io.github.milkshiift.GoofCord"
    "io.github.finefindus.Hieroglyphic"
    "dev.bragefuglseth.Keypunch"
    "org.kde.konsole"
    "io.gitlab.librewolf-community"
    "io.github.mhogomchungu.media-downloader"
    "md.obsidian.Obsidian"
    "re.sonny.Playhouse"
    "com.protonvpn.www"
    "org.torproject.torbrowser-launcher"
    "org.videolan.VLC"
    "org.kde.yakuake"
  ];

  environment.defaultPackages = lib.mkForce []; # Delete all default phkgs

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
}
