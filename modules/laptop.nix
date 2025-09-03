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

/*services.tlp.enable = true;

services.tlp.settings = {
  # Disable all CPU-related TLP control
  CPU_SCALING_GOVERNOR_ON_AC = "ignore";
  CPU_SCALING_GOVERNOR_ON_BAT = "ignore";
  CPU_SCALING_MIN_FREQ_ON_AC = "0";
  CPU_SCALING_MAX_FREQ_ON_AC = "0";
  CPU_SCALING_MIN_FREQ_ON_BAT = "0";
  CPU_SCALING_MAX_FREQ_ON_BAT = "0";
  CPU_ENERGY_PERF_POLICY_ON_AC = "ignore";
  CPU_ENERGY_PERF_POLICY_ON_BAT = "ignore";
  CPU_HWP_ON_AC = "ignore";
  CPU_HWP_ON_BAT = "ignore";
  CPU_BOOST_ON_AC = 1;
  CPU_BOOST_ON_BAT = 1;
};
*/
