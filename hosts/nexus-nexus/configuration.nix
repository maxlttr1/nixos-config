{
  custom.hostname = "nexus-nexus";

  custom.borgbackup.enable = true;
  custom.fail2ban.enable = true;
  custom.intel.enable = true;
  custom.powertopAutotune.enable = true;
  custom.ssh.enable = true;
  custom.swap = {
    swapFile = {
      enable = true;
      sizeGiB = 8;
    };
    zramSwap.enable = true;
    swappiness = 30;
  };
}
