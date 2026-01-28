{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs.stable; [
    nerd-fonts.mononoki
  ];
}
