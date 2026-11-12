{ config, lib, ... }:

lib.mkIf (config.custom.disko.enable && config.custom.disko.layout == "zfs-raid1-server") {
  disko.devices = {
    disk = {
      disk1 = {
        type = "disk";
        device = "/dev/disk/by-id/REPLACE_WITH_DISK1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ]; # #### NEED TO SETUP BOOTLOADER TO USE BOTH DISKS
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };

      disk2 = {
        type = "disk";
        device = "/dev/disk/by-id/REPLACE_WITH_DISK2";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
    };

    zpool.zroot = {
      type = "zpool";
      mode = "mirror";
      mountpoint = "/";
      rootFsOptions = {
        compression = "zstd";
      };
      datasets = {
        "root" = {
          type = "zfs_fs";
          mountpoint = "/";
        };
      };
    };
  };
}
