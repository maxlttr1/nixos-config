{ pkgs, lib, ... }:

{
  # Flatpaks
  services.flatpak.packages = [
    "org.bleachbit.BleachBit"
    #"com.usebottles.bottles"
    "com.google.Chrome"
    #"de.leopoldluley.Clapgrep"
    #"org.gnome.DejaDup"
    "io.github.milkshiift.GoofCord"
    "io.github.finefindus.Hieroglyphic"
    #"org.inkscape.Inkscape"
    "org.libreoffice.LibreOffice"
    "io.gitlab.librewolf-community"
    "io.github.mhogomchungu.media-downloader"
    #"com.obsproject.Studio"
    #"md.obsidian.Obsidian"
    "com.protonvpn.www"
    "org.mozilla.Thunderbird"
    "org.torproject.torbrowser-launcher"
    "com.github.jeromerobert.pdfarranger"
  ];

  environment.defaultPackages = lib.mkForce []; # Delete all default pkgs

  environment.systemPackages = 
    (with pkgs; [
      cmake
      compose2nix
      dig
      direnv
      ffmpeg
      # gnupg
      grex # Command-line tool for generating regular expressions from user-provided test cases
      mask # A CLI task runner defined by a simple markdown file
      md2pdf
      moreutils # to get vipe
      nmap
      papirus-icon-theme
      powershell
      (rstudioWrapper.override {
        packages = with rPackages; [ FactoMineR ];
      })
      sops
      tcpdump
      texliveFull
      #veracrypt
      vlc
      kdePackages.yakuake
      yt-dlp


      ninja
      gcc
      cmake 
      gnumake
      gdb
    ])
    ++
    (with pkgs.alternative; [
    ]);
  
  fonts.packages = with pkgs; [
    nerd-fonts.mononoki
  ];

  services.flatpak = {
    enable = true;
    update = {
      auto = {
        enable = false;
        onCalendar = "weekly";
      };
    };
  };
}
