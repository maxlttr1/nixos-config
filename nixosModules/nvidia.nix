{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    custom.nvidia.enable = lib.mkEnableOption "Enable NVIDIA GPU support";
  };

  config = lib.mkIf config.custom.nvidia.enable {
    # Enable opengl
    hardware.graphics.enable = true;

    # Drivers
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true; # Wayland requirement

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
      # of just the bare essentials.
      #powerManagement.enable = false;

      open = false;

      nvidiaSettings = true; # Enable the Nvidia settings menu, accessible via `nvidia-settings`.
    };

    # Thermald proactively prevents overheating on Intel CPUs and works well with other tools
    services.thermald.enable = true;
  };
}
