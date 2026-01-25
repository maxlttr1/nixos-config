{ pkgs, ... }:

{
  home.packages = with pkgs.stable; [
    age
    # at
    bat
    cron
    curl
    eza
    fastfetch
    fd
    fzf
    htop
    magic-wormhole
    ncdu
    powertop
    ranger
    ripgrep-all
    tldr
    unp
    unrar
    vim
    wget
  ];
}
