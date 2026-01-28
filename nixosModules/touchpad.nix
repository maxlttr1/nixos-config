{ lib, config, ... }:

{
  options = {
    touchpad.enable = lib.mkEnableOption "Enable touchpad support";
  };

  config = lib.mkIf config.touchpad.enable {
    boot.kernelParams = [ "psmouse.synaptics_intertouch=0" ];
  };
}
