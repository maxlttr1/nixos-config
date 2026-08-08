{ settings, ... }:

{
  custom.bluetooth.enable = true;
  custom.eduvpn.enable = true;
  custom.flatpak.enable = true;
  custom.gaming.enable = true;
  custom.gaming.sunshine.enable = true;
  custom.gaming.moonlight.enable = true;
  custom.intel.enable = true;
  custom.kdePlasma.enable = true;
  custom.ld.enable = true;
  custom.pipewire.enable = true;
  custom.swap = {
    swapFile = {
      enable = true;
      sizeGiB = 16;
    };
    zramSwap = {
      enable = true;
      memoryPercent = 100;
    };
    swappiness = 150;
    resume = {
      enable = true;
      offset = 33624064;
      device = "3f6e674d-f4f2-4589-bc34-a0dffb35fb6b";
    };
  };
  custom.tlp.enable = true;
  custom.touchpad.enable = true;
  custom.vms.enable = true;

  services.teamviewer.enable = true;

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
    fsType = "none";
    options = [
      "bind"
      "exec"
    ];
  };

  boot.initrd.luks.devices."crypted".device =
    "/dev/disk/by-uuid/c3e6f523-f97e-4166-8208-06eefd778df2";
}
