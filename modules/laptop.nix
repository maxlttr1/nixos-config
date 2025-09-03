{
  services.power-profiles-daemon.enable = false;
  
  services.tlp = {
    enable = true;
    settings = {
      TLP_DEFAULT_MODE="BAT";
      START_CHARGE_THRESH_BAT0=75;
      STOP_CHARGE_THRESH_BAT0=80;
    };
  };
}
