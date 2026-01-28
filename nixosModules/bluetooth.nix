{ lib, config, ... }:

{
  options = {
    bluetooth.enable = lib.mkEnableOption "Enable system Bluetooth";
  };

  config = lib.mkIf config.bluetooth.enable {
    hardware.bluetooth.enable = true;
  };
}
