{ pkgs, lib, ... }:

{
  # Flatpaks
  services.flatpak.packages = [
    "co.logonoff.awakeonlan"
    "com.usebottles.bottles"
    "com.google.Chrome"
    "com.gitlab.davem.ClamTk"
    "io.github.lainsce.Colorway"
    "com.github.tchx84.Flatseal"
    "io.github.milkshiift.GoofCord"
    "io.github.finefindus.Hieroglyphic"
    "dev.bragefuglseth.Keypunch"
    "io.github.mhogomchungu.media-downloader"
    "com.obsproject.Studio"
    "md.obsidian.Obsidian"
    "org.onionshare.OnionShare"
    "io.github.nate_xyz.Paleta"
    "com.protonvpn.www"
    "org.torproject.torbrowser-launcher"
    "org.videolan.VLC"
  ];

  environment.defaultPackages = lib.mkForce []; # Delete all default pkgs

  environment.systemPackages = 
    (with pkgs; [
      android-tools
      bibata-cursors
      burpsuite
      cmake
      compose2nix
      conda
      ffmpeg
      kdePackages.filelight
      gcc
      gnumake
      jdk
      kdePackages.konsole
      libwebp
      nixfmt-classic
      nix-prefetch-scripts
      nodejs
      papirus-icon-theme
      powertop
      python313Full
      rstudio
      scrcpy
      sops
      sqlite
      universal-android-debloater
      veracrypt
      whitesur-kde
      wireshark
      kdePackages.yakuake
    ])
    ++
    (with pkgs.alternative; [
    ]);
  
  fonts.packages = with pkgs; [
    #nerd-fonts.fantasque-sans-mono
    #nerd-fonts.jetbrains-mono
    nerd-fonts.mononoki
  ];

  services.flatpak = {
    enable = true;
    update = {
      auto = {
        enable = true;
        onCalendar = "weekly";
      };
    };
  };
}
