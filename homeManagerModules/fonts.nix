{ config, lib, pkgs, ... }:

{
  options.fonts.enable = lib.mkEnableOption "fonts configuration";

  config = lib.mkIf config.fonts.enable {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs.stable; [
      nerd-fonts.mononoki
    ];
  };
}
