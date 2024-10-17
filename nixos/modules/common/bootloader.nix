{ grub-disk, ... }:

{
  boot.loader = if (builtins.pathExists "/sys/firmware/efi") then {
    # UEFI mode
    systemd-boot.enable = true;
    systemd-boot.efiSupports = true;
  } else {
    # BIOS mode
    grub.enable = true;
    grub.device = "${grub-disk}";
  };
}
