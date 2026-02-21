{ lib, config, ... }:

{
  options = {
    custom.intel.enable = lib.mkEnableOption "Enable Intel CPU/GPU support";
  };

  config = lib.mkIf config.custom.intel.enable {
    # Enable opengl
    hardware.graphics.enable = true;

    # Drivers
    services.xserver.videoDrivers = [ "modesetting" ]; # Intel

    # Thermald proactively prevents overheating on Intel CPUs and works well with other tools
    services.thermald.enable = true;

    hardware.cpu.intel.updateMicrocode = true;
  };
}
