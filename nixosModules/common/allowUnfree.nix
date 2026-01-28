{ lib, config, pkgs, ... }:

{
  options = {
    allowUnfree.enable = lib.mkEnableOption "Allow unfree packages";
  };

  config = lib.mkIf config.allowUnfree.enable {
    nixpkgs.config.allowUnfree = true;
  };
}
