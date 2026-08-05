{ lib, ... }:

{
  options = {
    custom.disko = {
      enable = lib.mkEnableOption "Enable Disko configuration";
      device = lib.mkOption {
        type = lib.types.str;
        description = "The device to be used for Disko configuration";
        examples = [
          "/dev/disk/by-id/nvme-WDC_PC_SN530_SDBPNPZ-256G-1002_21371G804437"
          "/dev/vda"
        ];
      };
      layout = lib.mkOption {
        description = "The layout of Disko configuration to be used.";
        default = "encrypted-ext4";
        type = lib.types.enum [
          "ext4"
          "encrypted-ext4"
          "encrypted-impermance-btrfs"
        ];
      };
    };
  };
}