{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../hardware-configuration.nix
      ../modules/stylix.nix
      ../modules/pkgs.nix
      ../modules/laptop.nix
      ../modules/services.nix
      ../modules/users.nix
      ../modules/system.nix
      ../modules/display.nix
      ../modules/security.nix
      ../modules/networking.nix 
      ../modules/defaults.nix
    ];
  
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    dates = "17:00";
  };
# This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
