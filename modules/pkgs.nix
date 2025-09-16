{ pkgs, lib, ... }:

{
  # Flatpaks
  services.flatpak.packages = [
    "com.usebottles.bottles"
    "com.google.Chrome"
    "de.leopoldluley.Clapgrep"
    "org.gnome.DejaDup"
    "io.github.milkshiift.GoofCord"
    "io.github.finefindus.Hieroglyphic"
    "io.gitlab.librewolf-community"
    "io.github.mhogomchungu.media-downloader"
    "com.obsproject.Studio"
    "md.obsidian.Obsidian"
    "com.protonvpn.www"
    "org.torproject.torbrowser-launcher"
    "com.github.jeromerobert.pdfarranger"
  ];

  environment.defaultPackages = lib.mkForce []; # Delete all default pkgs

  environment.systemPackages = 
    (with pkgs; [
      #bibata-cursors
      cmake
      compose2nix
      dig
      ffmpeg
      gcc
      gdb
      gnumake
      gnupg
      jdk
      mask #A CLI task runner defined by a simple markdown file
      md2pdf
      moreutils # to get vipe
      nmap
      nodejs
      papirus-icon-theme
      powershell
      python313Full
      rstudio
      sops
      tcpdump
      veracrypt
      vlc
      kdePackages.yakuake
      yt-dlp
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
