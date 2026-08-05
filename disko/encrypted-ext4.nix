{ config, lib, ... }:

lib.mkIf (config.custom.disko.enable && config.custom.disko.layout == "encrypted-ext4") {
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "${config.custom.disko.device}";
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
            root = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                passwordFile = "/tmp/disk-encryption.key";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                };
              };
            };
          };
        };
      };
    };
  };
}
