{ lib, config, pkgs, ... }:

{
  options = {
    custom.allowUnfree.enable = lib.mkEnableOption "Allow unfree packages";
  };

  config = lib.mkIf config.custom.allowUnfree.enable {
    nixpkgs.config.allowUnfree = true;
  };
}
