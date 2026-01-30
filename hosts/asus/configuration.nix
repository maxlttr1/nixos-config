{
  hostname = "asus-maxlttr";

  atd.enable = true;
  bluetooth.enable = true;
  eduvpn.enable = true;
  flatpak.enable = true;
  intel.enable = true;
  kdePlasma.enable = true;
  ld.enable = true;
  pipewire.enable = true;
  swapFile.enable = true;
  swapFile.sizeGiB = 18;
  tlp.enable = true;
  touchpad.enable = true;
  vms.enable = true;

  fileSystems."/home/maxlttr/mountedDisk" ={
    device = "/dev/disk/by-uuid/d8d4d44d-0461-46ff-a3df-2141b02aefec";
    fsType = "ext4";
    options = [
      "nofail"
	  "nosuid"
	  "nodev"
    ];
  };
}
