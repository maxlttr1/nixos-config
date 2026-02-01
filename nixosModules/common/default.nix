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
    ./users.nix
  ];

  allowUnfree.enable = true;
  apparmor.enable = true;
  auditd.enable = true;
  autoCpufreq.enable = true;
  autoUpgrade.enable = true;
  bootloader.enable = true;
  clamav.enable = true;
  docker.enable = true;
  experimentalFeatures.enable = true;
  fail2ban.enable = true;
  firewall.enable = true;
  firmware.enable = true;
  networkManager.enable = true;
  noexec.enable = true;
  optimise.enable = true;
  ssh.enable = true;
  syncthing.enable = true;
  systemd.enable = true;
  tailscale.enable = true;
  timezoneLocales.enable = true;
  users.enable = true;
}
