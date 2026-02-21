{ lib, config, ... }:

{
  options = {
    custom.tlp.enable = lib.mkEnableOption "Enable TLP";
  };

  config = lib.mkIf config.custom.tlp.enable {
    services.power-profiles-daemon.enable = false;

    services.tlp = {
      enable = true;
      settings = {
        TLP_DEFAULT_MODE = "BAT";
        START_CHARGE_THRESH_BAT0 = 55;
        STOP_CHARGE_THRESH_BAT0 = 60;
      };
    };
  };
}

