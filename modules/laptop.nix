{
  services.power-profiles-daemon.enable = false;
  powerManagement.enable = true; # Stock NixOS power management tool which allows for managing hibernate and suspend states
  services.tlp.enable = true; # Enable TLP
}
