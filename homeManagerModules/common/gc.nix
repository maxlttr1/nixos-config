{ config, lib, ... }:

{
  options.gc.enable = lib.mkEnableOption "automatic nix garbage collection";

  config = lib.mkIf config.gc.enable {
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };
}
