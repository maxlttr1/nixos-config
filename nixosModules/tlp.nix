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

        INTEL_GPU_MAX_FREQ_ON_BAT = 300;
        INTEL_GPU_BOOST_FREQ_ON_BAT = 300;

        WIFI_PWR_ON_AC = "off";
        WIFI_PWR_ON_BAT = "on";

        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "quiet";

        MEM_SLEEP_ON_AC = "s2idle";
        MEM_SLEEP_ON_BAT = "deep";

        CPU_DRIVER_OPMODE_ON_AC = "active";
        CPU_DRIVER_OPMODE_ON_BAT = "active";
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_MAX_PERF_ON_BAT = 50;
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 0;

        DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth nfc wwan";
        DEVICES_TO_ENABLE_ON_STARTUP = "wifi";
        DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "bluetooth nfc wifi wwan";

        PCIE_ASPM_ON_BAT = "powersupersave";
      };
    };
  };
}
