{ pkgs, ... }:

let
  xenlism-grub-theme = pkgs.fetchFromGitHub
  {
    owner = "Arkachur";
    repo = "NixOS-grub-theme";
    rev = "5309fdf51374af71a34a4caf9ee2f290a86c5a61";
    sha256 = "sha256-LNT1SKxQDvdHzsOCMSA0aTBM5TY3/ReLLVCVS+9hgh8=";
  };
in

{
  boot.loader = {
    grub = {
      enable = true;
      theme = xenlism-grub-theme;
      #device = "nodev"; # Disko will handle it
      efiSupport = true;
      efiInstallAsRemovable = true;
      configurationLimit = 15;
      #useOSProber = true;
    };
    #efi.canTouchEfiVariables = true;
  };
  #boot.loader.systemd-boot.enable = true;
}
