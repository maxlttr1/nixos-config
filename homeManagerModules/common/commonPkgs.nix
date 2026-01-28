{ config, lib, pkgs, ... }:

{
  options.commonPkgs.enable = lib.mkEnableOption "common packages";

  config = lib.mkIf config.commonPkgs.enable {
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
      lf
      magic-wormhole
      ncdu
      powertop
      ripgrep-all
      tldr
      unp
      unrar
      vim
      wget
    ];
  };
}
