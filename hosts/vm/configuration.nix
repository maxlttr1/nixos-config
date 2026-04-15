{ lib, ... }:

{
  custom.hostname = "vm";

  custom.impermanence.enable = true;
  custom.intel.enable = true;


  custom.boot.enable = lib.mkForce true;
  boot.loader.systemd-boot.enable = true;
}
