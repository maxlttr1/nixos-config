{ lib, config, ... }:

{
  options = {
    custom.ld.enable = lib.mkEnableOption "Enable nix-ld for running unpatched binaries";
  };

  config = lib.mkIf config.custom.ld.enable {
    programs.nix-ld.enable = true;
  };
}
