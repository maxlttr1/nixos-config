{ settings, ... }:

{
  custom.hostname = "terra-terra";

  custom.bluetooth.enable = true;
  custom.eduvpn.enable = true;
  custom.flatpak.enable = true;
  custom.intel.enable = true;
  custom.kdePlasma.enable = true;
  custom.ld.enable = true;
  custom.pipewire.enable = true;
  custom.swap = {
    swapFile = {
      enable = true;
      sizeGiB = 8;
    };
    zramSwap.enable = true;
    swappiness = 10;
  };
  custom.tlp.enable = true;
  custom.touchpad.enable = true;
  custom.vms.enable = true;

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
    fsType = "ext4";
    options = [
      "nofail"
      "bind"
      "exec"
    ];
  };

  boot.initrd.luks.devices."crypted".device =
    "/dev/disk/by-uuid/c3e6f523-f97e-4166-8208-06eefd778df2";
}
