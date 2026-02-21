{ config, lib, pkgs, ... }:

{
  options.custom.fonts.enable = lib.mkEnableOption "fonts configuration";

  config = lib.mkIf config.custom.fonts.enable {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs.stable; [
      nerd-fonts.mononoki
    ];
  };
}
