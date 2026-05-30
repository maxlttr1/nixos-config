{ lib, config, ... }:

{
  options = {
    custom.autoCpufreq.enable = lib.mkEnableOption "Enable auto-cpufreq CPU frequency scaling";
  };

  config = lib.mkIf config.custom.autoCpufreq.enable {
    services.auto-cpufreq.enable = true;
    services.power-profiles-daemon.enable = false;
  };
}
