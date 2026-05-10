{ lib, config, ... }:

{
  options = {
    custom.nix-optimise.enable = lib.mkEnableOption "Enable Nix optimization";
  };

  config = lib.mkIf config.custom.nix-optimise.enable {
    /*
      nix.optimise = {
        automatic = true;
        dates = ["weekly"];
        persistent = true;
      };
    */

    nix.settings.auto-optimise-store = true; # Optimise store during every build. This may slow down builds

    nix.daemonCPUSchedPolicy = "idle"; # Idle is for extremely low-priority tasks that should only be run when no other task requires CPU time

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    nix.settings = {
      substituters = [
        "https://nix-community.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
        "https://maxlttr1.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "maxlttr1.cachix.org-1:+p43ls2stF7Xn9M7lcbH6pKa9e/2pvX9Itk4MPrCK7M="
      ];
    };
  };
}
