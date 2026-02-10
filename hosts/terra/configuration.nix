{ settings, ... }:

{
  hostname = "terra";

  atd.enable = true;
  bluetooth.enable = true;
  eduvpn.enable = true;
  flatpak.enable = true;
  intel.enable = true;
  kdePlasma.enable = true;
  ld.enable = true;
  pipewire.enable = true;
  swap.swapFile.enable = true;
  swap.swapFile.sizeGiB = 18;
  swap.zramSwap.enable = true;
  tlp.enable = true;
  touchpad.enable = true;
  vms.enable = true;

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
  fileSystems."/home/${settings.username}/mountedDisk/syncthing/cours/polytech" = {
    device = "/home/${settings.username}/mountedDisk/syncthing/cours/polytech";
    options = [
      "nofail"
      "bind"
      "exec"
    ];
  };

  boot.initrd.luks.devices."crypted".device = "/dev/disk/by-uuid/c3e6f523-f97e-4166-8208-06eefd778df2";
}
