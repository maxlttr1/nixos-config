{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/vda";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              label = "ESP";
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "umask=0077"
                  "dmask=0077"
                ];
              };
            };
            root = {
              size = "100%";
              label = "root";
              content = {
                type = "luks";
                name = "crypted";
                passwordFile = "/tmp/disk-encryption.key";
                content = {
                  type = "btrfs";
                  extraArgs = [ 
                    "-L"
                    "nixos"
                    "-f" # force creation
                  ];
                  postCreateHook = ''
                    mount -t btrfs /dev/disk/by-label/nixos /mnt
                    btrfs subvolume snapshot -r /mnt/root /mnt/root-blank
                    umount /mnt
                  '';
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = [
                        "subvol=root"
                        "compress=zstd"
                        "noatime"
                        "nosuid"
                        "nodev"
                      ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "subvol=nix"
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/persist" = {
                      mountpoint = "/persist";
                      mountOptions = [
                        "subvol=persist"
                        "compress=zstd"
                        "noatime"
                        "nosuid"
                        "nodev"
                      ];
                    };
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
