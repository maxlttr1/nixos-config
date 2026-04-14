{ lib, settings, ... }:

{
  custom.hostname = "test";

  custom.impermanence.enable = true;
  custom.atd.enable = true;
  custom.bluetooth.enable = true;
  custom.flatpak.enable = true;
  custom.nvidia.enable = true;
  custom.kdePlasma.enable = true;
  custom.ld.enable = true;
  custom.pipewire.enable = true;
  custom.swap.zramSwap.enable = true;


  custom.usbguard.enable = lib.mkForce false;
}
