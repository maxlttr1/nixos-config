{ pkgs, lib, ... }:

{
  # Flatpaks
  services.flatpak.packages = [
    "co.logonoff.awakeonlan"
    "com.usebottles.bottles"
    "com.google.Chrome"
    "com.gitlab.davem.ClamTk"
    "de.leopoldluley.Clapgrep"
    "io.github.lainsce.Colorway"
    "org.gnome.DejaDup"
    "com.github.tchx84.Flatseal"
    "io.github.milkshiift.GoofCord"
    "io.github.finefindus.Hieroglyphic"
    "org.kde.kdenlive"
    "dev.bragefuglseth.Keypunch"
    "io.github.mhogomchungu.media-downloader"
    "com.obsproject.Studio"
    "md.obsidian.Obsidian"
    "org.onionshare.OnionShare"
    "io.github.nate_xyz.Paleta"
    "com.protonvpn.www"
    "org.signal.Signal"
    "org.torproject.torbrowser-launcher"
    "com.github.xournalpp.xournalpp"
  ];

  environment.defaultPackages = lib.mkForce []; # Delete all default pkgs

  environment.systemPackages = 
    (with pkgs; [
      bibata-cursors
      cmake
      compose2nix
      dig
      ffmpeg
      gcc
      gdb
      gnumake
      gnupg
      jdk
      kdePackages.konsole
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
      whitesur-kde
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
