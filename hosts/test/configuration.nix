{ settings, ... }:

{
  custom.hostname = "test";

  custom.impermanence.enable = true;
  custom.impermanence.retentionDays = "0";
  custom.impermanence.diskDevice = "/dev/sda2";
  custom.atd.enable = true;
  custom.bluetooth.enable = true;
  custom.flatpak.enable = true;
  custom.nvidia.enable = true;
  custom.kdePlasma.enable = true;
  custom.ld.enable = true;
  custom.pipewire.enable = true;
  custom.swap.zramSwap.enable = true;
}
