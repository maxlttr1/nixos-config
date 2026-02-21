{ lib, config, ... }:

{
  options = {
    custom.touchpad.enable = lib.mkEnableOption "Enable touchpad support";
  };

  config = lib.mkIf config.custom.touchpad.enable {
    boot.kernelParams = [ "psmouse.synaptics_intertouch=0" ];
  };
}
