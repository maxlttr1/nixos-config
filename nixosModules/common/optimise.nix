{ lib, config, ... }:

{
  options = {
    custom.optimise.enable = lib.mkEnableOption "Enable Nix store optimization and garbage collection";
  };

  config = lib.mkIf config.custom.optimise.enable {
    /*nix.optimise = {
      automatic = true;
      dates = ["weekly"];
      persistent = true;
    };*/
    
    nix.settings.auto-optimise-store = true; # Optimise store during every build. This may slow down builds

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };
}
