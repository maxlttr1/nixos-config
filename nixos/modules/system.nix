{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  
  # Kernel 
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  # Enable opengl
  hardware.graphics.enable = true;
 
  # Drivers
  #services.xserver.videoDrivers = [ "nvidia" ];
  #hardware.nvidia.modesetting.enable = true;
  services.xserver.videoDrivers = [ "modesetting" ]; # Intel
}
