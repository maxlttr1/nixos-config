{ config, pkgs, ... }:

{
  # Enable TLP
  services.tlp.enable = true;
  services.power-profiles-daemon.enable = false;

  # Thermald proactively prevents overheating on Intel CPUs and works well with other tools
  services.thermald.enable = true;
}
