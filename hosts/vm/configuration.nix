{ lib, ... }:

{
  custom.hostname = "vm";

  # custom.impermanence.enable = true;
  custom.intel.enable = true;


  custom.boot.enable = lib.mkForce false;
  
  boot.loader = {
    grub = {
      enable = true;
      device = "/dev/vda1";
    };
  };
}
