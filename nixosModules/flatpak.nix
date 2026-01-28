{ lib, config, pkgs, ... }:

{
  options = {
    flatpak.enable = lib.mkEnableOption "Enable Flatpak";
  };

  config = lib.mkIf config.flatpak.enable {
    services.flatpak.enable = true;
  };
}
