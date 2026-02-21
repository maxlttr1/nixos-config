{ lib, config, ... }:

{
  options = {
    custom.bluetooth.enable = lib.mkEnableOption "Enable system Bluetooth";
  };

  config = lib.mkIf config.custom.bluetooth.enable {
    hardware.bluetooth.enable = true;
  };
}
