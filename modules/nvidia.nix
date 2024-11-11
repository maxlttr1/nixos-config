{
  # Enable opengl
  #hardware.graphics.enable = true; #> NixOS 24.11
  hardware.opengl.enable = true;

  # Drivers
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia.open = false; #Since driver version 560, you also will need to decide whether to use the open-source or proprietary modules
}