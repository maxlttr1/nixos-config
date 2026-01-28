{ lib, config, ... }:

{
  options = {
    experimentalFeatures.enable = lib.mkEnableOption "Enable Nix experimental features (nix-command and flakes)";
  };

  config = lib.mkIf config.experimentalFeatures.enable {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
  };
}


