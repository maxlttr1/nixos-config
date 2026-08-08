{ lib, config, ... }:

{
  options = {
    custom.swap.swapFile.enable = lib.mkEnableOption "Enable swapFile";
    custom.swap.swapFile.sizeGiB = lib.mkOption {
      type = lib.types.ints.unsigned;
      default = 0;
      description = "Swap file size in GiB";
    };
    custom.swap.zramSwap.enable = lib.mkEnableOption "Enable zram swap";
    custom.swap.zramSwap.memoryPercent = lib.mkOption {
      type = lib.types.ints.positive;
      default = 25;
      description = "Percentage of total RAM to use for zram swap";
    };
    custom.swap.swappiness = lib.mkOption {
      type = lib.types.ints.positive;
      default = 60;
      description = "Controls Swappiness (how aggressively swap space is used)";
    };
    custom.swap.resume.enable = lib.mkEnableOption "Enable resume from swap";
    custom.swap.resume.offset = lib.mkOption {
      type = lib.types.ints.positive;
      description = "Resume offset for swap file: filefrag -v /var/lib/swapfile | head";
    };
    custom.swap.resume.device = lib.mkOption {
      type = lib.types.str;
      description = "Resume device for swap file (UUID of the root partition for a swapfile: lsblk -f)";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.custom.swap.swapFile.enable {
      swapDevices = [
        {
          device = "/var/lib/swapfile";
          #label = "swapfile";
          # randomEncryption.enable = true;
          size = config.custom.swap.swapFile.sizeGiB * 1024; # Size is in megabytes
          # priority = 2048; # Priority is a value between 0 and 32767. Higher numbers indicate higher priority. null lets the kernel choose a priority, which will show up as a negative value.
          options = [ "discard=once" ]; # Runs discard exactly once when the swap is enabled
        }
      ];
    })
    (lib.mkIf config.custom.swap.zramSwap.enable {
      zramSwap = {
        enable = true;
        memoryPercent = config.custom.swap.zramSwap.memoryPercent;
      };

      boot.kernel.sysctl = {
        "vm.page-cluster" = 0; # Disable page clustering to reduce swap latency, increase this value to 1 or 2 if you are using physical swap (1 if ssd, 2 if hdd, 3 is the default value)
        "vm.vfs_cache_pressure" = 50; # Lowering it from the default value of 100 makes the kernel less inclined to reclaim VFS cache
      };

    })
    (lib.mkIf config.custom.swap.resume.enable {
      boot.kernelParams = [ "resume_offset=${toString (config.custom.swap.resume.offset)}" ];
      boot.resumeDevice = "/dev/disk/by-uuid/${config.custom.swap.resume.device}";
    })
    {
      boot.kernel.sysctl = {
        "vm.swappiness" = config.custom.swap.swappiness;
      };
    }
  ];
}
