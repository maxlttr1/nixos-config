{
  /*boot.loader = {
    grub = {
      enable = true;
      device = "nodev"; # Disko will handle it
      efiSupport = true;
      efiInstallAsRemovable = true;
      configurationLimit = 30;
      #useOSProber = true;
    };
  };*/

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };
}
