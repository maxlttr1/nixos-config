{ grub-disk, ... }:

{
  boot.loader = 
    let
      isUEFI = builtins.pathExists "/sys/firmware/efi";
    in 
  { 
    if isUEFI then {
      efi.canTouchEfiVariables = true;
      grub = {
        efiSupport = true;
        device = "nodev"; #GRUB not tied to a specific physical disk
    } else {
    grub.device = "${grub-disk}";
    }
    grub = {
      enable = true;
      configurationLimit = 10;
    }
  };
}
