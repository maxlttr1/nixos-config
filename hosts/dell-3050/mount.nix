{
  fileSystems."/mnt/nvme0n1" = {
    device = "/dev/nvme0n1";
    fsType = "ext4";
  };
  fileSystems."/mnt/sda" = {
    device = "/dev/sda";
    fsType = "ext4";
  };
}