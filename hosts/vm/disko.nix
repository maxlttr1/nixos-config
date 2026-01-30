{
  disko.devices = {
    disk = {
      nvme0n1 = {
        type = "disk";
        device = "/dev/vda";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              label = "ESP";
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "100%";
              label = "root";
              content = {
                type = "btrfs";
                extraArgs = ["-f"]; # Force creation
                subvolumes = {
                  "/root" = {
                    mountpoint = "/";
                    mountOptions = ["subvol=root" "compress=zstd" "noatime"];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = ["subvol=nix" "compress=zstd" "noatime"];
                  };
                  "/persist" = {
                    mountpoint = "/persist";
                    mountOptions = ["subvol=persist" "compress=zstd" "noatime"];
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
