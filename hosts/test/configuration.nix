{ settings, ... }:

{
  hostname = "test-maxlttr";

  impermanence.enable = true;
  impermanence.retentionDays = "0";
  impermanence.diskDevice = "/dev/sda2";
  atd.enable = true;
  bluetooth.enable = true;
  flatpak.enable = true;
  nvidia.enable = true;
  kdePlasma.enable = true;
  ld.enable = true;
  pipewire.enable = true;
}
