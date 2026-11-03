{ settings, ... }:

{
  custom.autoFlakeUpdate.enable = true;
  custom.borgbackup.enable = true;
  custom.intel.enable = true;
  custom.ssh.enable = true;
  custom.swap = {
    swapFile = {
      enable = true;
      sizeGiB = 8;
    };
    zramSwap.enable = true;
  };
  custom.syncthing.enable = true;

  fileSystems."/home/${settings.username}/mountedDisk" = {
    device = "/dev/mapper/crypted";
    fsType = "ext4";
    options = [
      "nofail"
      "nosuid"
      "nodev"
      "noatime"
      "noexec"
    ];
  };

  environment.etc.crypttab.text = ''
    crypted UUID=JZDKJDKJDLKDOKDLDFK /root/luks-keyfile
  '';
}
