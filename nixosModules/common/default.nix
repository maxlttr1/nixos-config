{
  imports = [
    ./docker/docker.nix
    ./allowUnfree.nix
    ./apparmor.nix
    ./auditd.nix
    ./autoCpufreq.nix
    ./autoUpgrade.nix
    ./bootloader.nix
    ./clamav.nix
    ./experimentalFeatures.nix
    ./fail2ban.nix
    ./firewall.nix
    ./firmware.nix
    ./hostname.nix
    ./kernel.nix
    ./networkManager.nix
    ./noexec.nix
    ./optimise.nix
    ./ssh.nix
    ./stateVersion.nix
    ./syncthing.nix
    ./systemd.nix
    ./tailscale.nix
    ./timezoneLocales.nix
    ./usbguard.nix
    ./users.nix
  ];

  custom.allowUnfree.enable = true;
  custom.apparmor.enable = true;
  custom.auditd.enable = true;
  custom.autoCpufreq.enable = true;
  custom.autoUpgrade.enable = true;
  custom.bootloader.enable = true;
  custom.clamav.enable = true;
  custom.docker.enable = true;
  custom.experimentalFeatures.enable = true;
  custom.fail2ban.enable = true;
  custom.firewall.enable = true;
  custom.firmware.enable = true;
  custom.networkManager.enable = true;
  custom.noexec.enable = true;
  custom.optimise.enable = true;
  custom.ssh.enable = true;
  custom.syncthing.enable = true;
  custom.systemd.enable = true;
  custom.tailscale.enable = true;
  custom.timezoneLocales.enable = true;
  custom.usbguard.enable = true;
  custom.users.enable = true;
}
