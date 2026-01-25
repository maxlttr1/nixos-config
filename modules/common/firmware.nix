{ pkgs, ... }:

{
  hardware.enableAllFirmware = true;
  services.fwupd.enable = true; # fwupd is a simple daemon allowing you to update some devices' firmware, including UEFI for several machines
}
