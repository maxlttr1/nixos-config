{ lib, config, ... }:

{
  options = {
    swapFile.enable = lib.mkEnableOption "Enable swapFile";
    swapFile.sizeGiB = lib.mkOption {
      type = lib.types.ints.unsigned;
      default = 0;
      description = "Swap file size in GiB";
    };
  };
  
  config = lib.mkIf config.swapFile.enable {
    swapDevices = [{
      device = "/var/lib/swapfile";
      #label = "swapfile";
      size = config.swapFile.sizeGiB * 1024; # Size is in megabytes
      priority = 2048; # Priority is a value between 0 and 32767. Higher numbers indicate higher priority. null lets the kernel choose a priority, which will show up as a negative value.
    }];

    /*zramSwap = {
      enable = true;
      priority = 5; # Default
    };*/
  };
}
