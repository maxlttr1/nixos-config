{ grub-disk, ... }:

{
  boot.loader = { 
    if (builtins.pathExists "/sys/firmware/efi") then {
      efi.canTouchEfiVariables = true;
      grub.efiSupport = true;
    }
    grub = {
      enable = true;
      configurationLimit = 10;
      device = "${grub-disk}";
    }
  };
}
