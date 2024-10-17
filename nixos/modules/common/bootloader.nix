{ grub-disk, ... }:

{
  boot.loader = { 
    if (builtins.pathExists "/sys/firmware/efi") then {
      efi.canTouchEfiVariables = true;
      grub = {
        efiSupport = true;
        device = "nodev"; #GRUB not tied to a specific physical disk
    }
    grub = {
      enable = true;
      configurationLimit = 10;
      device = "${grub-disk}";
    }
  };
}
