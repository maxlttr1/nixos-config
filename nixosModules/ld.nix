{ lib, config, ... }:

{
  options = {
    ld.enable = lib.mkEnableOption "Enable nix-ld for running unpatched binaries";
  };

  config = lib.mkIf config.ld.enable {
    programs.nix-ld.enable = true;
  };
}
