{ config, lib, ... }:

{
  options.custom.gc.enable = lib.mkEnableOption "automatic nix garbage collection";

  config = lib.mkIf config.custom.gc.enable {
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };
}
