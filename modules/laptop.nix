{
  services.power-profiles-daemon.enable = false;
  
  services.tlp = {
    enable = true;
    settings = {
      TLP_ENABLE=1;
      TLP_DEFAULT_MODE="BAT";
      START_CHARGE_THRESH_BAT0=75;
      STOP_CHARGE_THRESH_BAT0=80;
      RESTORE_THRESHOLDS_ON_BAT=1;
      DISK_DEVICES="nvme0n1";
      DISK_APM_LEVEL_ON_AC="254";
      DISK_APM_LEVEL_ON_BAT="128";
      #INTEL_GPU_MIN_FREQ_ON_AC=100;
      #INTEL_GPU_MIN_FREQ_ON_BAT=100;
      #INTEL_GPU_MAX_FREQ_ON_AC=1300;
      INTEL_GPU_MAX_FREQ_ON_BAT=500;
      #INTEL_GPU_BOOST_FREQ_ON_AC=1300;
      INTEL_GPU_BOOST_FREQ_ON_BAT=500;
      PLATFORM_PROFILE_ON_AC="performance";
      PLATFORM_PROFILE_ON_BAT="quiet";
      CPU_SCALING_GOVERNOR_ON_AC="performance";
      CPU_SCALING_GOVERNOR_ON_BAT="powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC="performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT="power";
      #CPU_MIN_PERF_ON_AC=0;
      #CPU_MAX_PERF_ON_AC=100;
      #CPU_MIN_PERF_ON_BAT=0;
      CPU_MAX_PERF_ON_BAT=40;
      CPU_BOOST_ON_AC=1;
      CPU_BOOST_ON_BAT=0;
      CPU_HWP_DYN_BOOST_ON_AC=1;
      CPU_HWP_DYN_BOOST_ON_BAT=0;
      PCIE_ASPM_ON_AC="default";
      PCIE_ASPM_ON_BAT="powersupersave";
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
