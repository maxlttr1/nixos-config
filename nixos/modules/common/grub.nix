{ grub-disk, ... }:

{
  boot.loader.grub.enable = true;        # Enable GRUB
  boot.loader.grub.devices = [ "${grub-disk}" ];  # Device for GRUB in>
  boot.loader.grub.useOSProber = true;   # Enable OS detection
  boot.loader.grub.configurationLimit = 10;
}
