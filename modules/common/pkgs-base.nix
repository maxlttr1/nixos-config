{ pkgs, ... }:

{
  environment.systemPackages = 
    (with pkgs; [
      age
      bat
      cron
      curl
      eza
      fastfetch
      fd
      fzf
      git
      htop
      magic-wormhole
      ncdu
      powertop
      ranger
      ripgrep-all
      tldr
      unp
      unrar
      wget
      xorg.xauth
      zellij
    ])
    ++
    (with pkgs.alternative; [
    ]);
}