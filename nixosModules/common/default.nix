{
  imports = [
    ./docker/docker.nix
    ./apparmor.nix
    ./autoUpgrade.nix
    ./boot.nix
    ./clamav.nix
    ./experimentalFeatures.nix
    ./firewall.nix
    ./firmware.nix
    ./fsOptimizations.nix
    ./hostname.nix
    ./kernel.nix
    ./networkManager.nix
    ./nix-optimise.nix
    ./stateVersion.nix
    ./syncthing.nix
    ./systemd.nix
    ./tailscale.nix
    ./timezoneLocales.nix
    ./usbguard.nix
    ./users.nix
  ];

  # custom.apparmor.enable = true;
  custom.autoUpgrade.enable = true;
  custom.boot.enable = true;
  custom.clamav.enable = true;
  custom.docker.enable = true;
  custom.experimentalFeatures.enable = true;
  custom.fsOptimizations.enable = true;
  custom.firewall.enable = true;
  custom.firmware.enable = true;
  custom.networkManager.enable = true;
  custom.nix-optimise.enable = true;
  custom.syncthing.enable = true;
  custom.systemd.enable = true;
  custom.tailscale.enable = true;
  custom.timezoneLocales.enable = true;
  custom.usbguard.enable = true;
  custom.users.enable = true;
}
