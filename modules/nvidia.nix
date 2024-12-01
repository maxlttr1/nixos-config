{ config, lib, pkgs, ... }:

{
  # Enable opengl
  hardware.graphics.enable = true;

  # Drivers
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    #powerManagement.enable = false;

    open = false; #Since driver version 560, you also will need to decide whether to use the open-source or proprietary modules

    # Enable the Nvidia settings menu,
	  # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Thermald proactively prevents overheating on Intel CPUs and works well with other tools
  services.thermald.enable = true;
}