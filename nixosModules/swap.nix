{ lib, config, ... }:

{
  options = {
    swap.swapFile.enable = lib.mkEnableOption "Enable swapFile";
    swap.swapFile.sizeGiB = lib.mkOption {
      type = lib.types.ints.unsigned;
      default = 0;
      description = "Swap file size in GiB";
    };
    swap.zramSwap.enable = lib.mkEnableOption "Enable zram swap";
    swap.zramSwap.memoryPercent = lib.mkOption {
      type = lib.types.ints.positive;
      default = 25;
      description = "Percentage of total RAM to use for zram swap";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.swap.swapFile.enable {
      swapDevices = [{
        device = "/var/lib/swapfile";
        #label = "swapfile";
        size = config.swap.swapFile.sizeGiB * 1024; # Size is in megabytes
        priority = 2048; # Priority is a value between 0 and 32767. Higher numbers indicate higher priority. null lets the kernel choose a priority, which will show up as a negative value.
      }];
    })
    (lib.mkIf config.swap.zramSwap.enable {
      zramSwap = {
        enable = true;
        memoryPercent = config.swap.zramSwap.memoryPercent;
      };
    })
  ];
}
