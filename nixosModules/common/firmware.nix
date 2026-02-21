{ lib, config, pkgs, ... }:

{
  options = {
    custom.firmware.enable = lib.mkEnableOption "Enable firmware updates and support";
  };

  config = lib.mkIf config.custom.firmware.enable {
    hardware.enableAllFirmware = true;
    services.fwupd.enable = true; # fwupd is a simple daemon allowing you to update some devices' firmware, including UEFI for several machines
  };
}
