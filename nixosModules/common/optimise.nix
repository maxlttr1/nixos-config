{ lib, config, ... }:

{
  options = {
    optimise.enable = lib.mkEnableOption "Enable Nix store optimization and garbage collection";
  };

  config = lib.mkIf config.optimise.enable {
    nix.optimise.automatic = true; #periodic optimisation of the nix store
    nix.settings.auto-optimise-store = true; #the store can be optimised during every build. This may slow down builds

    nix.gc = {
      #Automated Garbage collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };
}
