{ lib, config, ... }:

{
  options = {
    custom.experimentalFeatures.enable = lib.mkEnableOption "Enable Nix experimental features (nix-command and flakes)";
  };

  config = lib.mkIf config.custom.experimentalFeatures.enable {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
  };
}


