{ pkgs, settings, ... }:

{
  home.packages = with pkgs; [
    bleachbit
    # bottles
    # deja-dup
    direnv
    (discord.override {
      withVencord = true;
    })
    ffmpeg
    # gnupg
    grex # Command-line tool for generating regular expressions from user-provided test cases
    hieroglyphic
    libreoffice
    librewolf
    mask # A CLI task runner defined by a simple markdown file
    media-downloader
    moreutils # to get vipe
    # obs-studio
    # obsidian
    papirus-icon-theme
    pdfarranger
    # powershell
    # protonvpn-gui

    /*(rstudioWrapper.override {
      packages = with rPackages; [ FactoMineR ];
    })*/

    signal-desktop
    # texliveFull
    thunderbird
    tor-browser
    typst
    typst-live
    # veracrypt
    vlc
    kdePackages.yakuake
  ];
}
