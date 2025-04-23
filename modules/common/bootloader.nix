{ pkgs, ... }:

let
  xenlism-grub-theme = pkgs.fetchFromGitHub
  {
    owner = "Arkachur";
    repo = "NixOS-grub-theme";
    rev = "2e927f528ce6ce731f08b70e72968d54bc170509";
    sha256 = "sha256-SJhSNspKitDGGlvIeTvgvxZkrDZSX5r+Hp6yxLwemDs=";
  };
in

{
  boot.loader = {
    grub = {
      enable = true;
      theme = xenlism-grub-theme;
      device = "nodev"; # Disko will handle it
      efiSupport = true;
      efiInstallAsRemovable = true;
      configurationLimit = 30;
      #useOSProber = true;
    };
    #efi.canTouchEfiVariables = true;
  };
  #boot.loader.systemd-boot.enable = true;
}
