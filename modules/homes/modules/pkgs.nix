{ pkgs, settings, ... }:

{
  home.packages = with pkgs; [
    bleachbit
    # bottles
    # deja-dup
    direnv
    eduvpn-client
    ffmpeg
    # gnupg
    goofcord
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

    # texliveFull
    thunderbird
    tor-browser
    # veracrypt
    vlc
    kdePackages.yakuake
  ];
}