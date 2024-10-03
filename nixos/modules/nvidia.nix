{
   # Enable opengl
  hardware.graphics.enable = true;
 
  # Drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;
}

