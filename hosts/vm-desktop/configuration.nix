{
  custom.disko = {
    enable = true;
    device = "/dev/sda";
  };
  custom.kdePlasma.enable = true;
  custom.pipewire.enable = true;
  custom.swap = {
    swapFile = {
      enable = true;
      sizeGiB = 8;
    };
    zramSwap.enable = true;
    swappiness = 180;
  };
}
