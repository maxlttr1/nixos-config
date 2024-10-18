{ pkgs, isUEFI, settings, ... }:

{
  boot.loader = if isUEFI then {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        configurationLimit = 10;
        efiSupport = true;
        device = "nodev"; #GRUB not tied to a specific physical disk
      };
    } else {
      grub = {
        enable = true;
        configurationLimit = 10;
        device = settings.grub-disk;
        boot.loader.grub.theme = "${pkgs.libsForQt5.breeze-grub}/grub/themes/breeze";
      };
    };
}
