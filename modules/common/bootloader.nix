{
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev"; # Disko will handle it
      efiSupport = true;
      efiInstallAsRemovable = true;
      configurationLimit = 30;
      #useOSProber = true;
    };
    #efi.canTouchEfiVariables = true;
  };
  #boot.loader.systemd-boot.enable = true;
}
