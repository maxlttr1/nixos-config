{ lib, config, pkgs, ... }:

{
  options = {
    custom.flatpak.enable = lib.mkEnableOption "Enable Flatpak";
  };

  config = lib.mkIf config.custom.flatpak.enable {
    services.flatpak.enable = true;
  };
}
