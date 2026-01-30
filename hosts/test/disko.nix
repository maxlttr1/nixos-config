{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              label = "ESP";
              size = "512M";
              type = "ef00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };
            root = {
              size = "100%";
              label = "root";
              content = {
                type = "btrfs";
                extraArgs = ["-f"]; # force creation
                subvolumes = {
                  "/root" = {
                    mountpoint = "/";
                    mountoptions = ["subvol=root" "compress=zstd" "noatime"];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountoptions = ["subvol=nix" "compress=zstd" "noatime"];
                  };
                  "/persist" = {
                    mountpoint = "/persist";
                    mountoptions = ["subvol=persist" "compress=zstd" "noatime"];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
