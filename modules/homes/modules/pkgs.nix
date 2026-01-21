{ pkgs, settings, ... }:

{
  home.packages = with pkgs; [
    # bottles
    # deja-dup
    direnv
    (discord.override {
      withOpenASAR = true;
    })
    ffmpeg
    # gnupg
    grex # Command-line tool for generating regular expressions from user-provided test cases
    # mask # A CLI task runner defined by a simple markdown file
    # moreutils # to get vipe
    papirus-icon-theme
    # protonvpn-gui
    /*(rstudioWrapper.override {
      packages = with rPackages; [ FactoMineR ];
    })*/

    # texliveFull
    typst
    typst-live
    # veracrypt
    kdePackages.yakuake
  ];

  services.flatpak = {
    update.onActivation = true;
    packages = [
      "org.bleachbit.BleachBit"
      "com.google.Chrome"
      "io.github.finefindus.Hieroglyphic"
      "org.libreoffice.LibreOffice"
      "io.gitlab.librewolf-community"
      "io.github.mhogomchungu.media-downloader"
      # "md.obsidian.Obsidian"
      "com.obsproject.Studio"
      "com.github.jeromerobert.pdfarranger"
      "org.signal.Signal"
      "com.valvesoftware.Steam"
      "org.mozilla.Thunderbird"
      "org.torproject.torbrowser-launcher"
      "org.videolan.VLC"
    ];
  };
}
