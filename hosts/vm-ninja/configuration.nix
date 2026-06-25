{ settings, ... }:

{
  custom.hostname = "vm-nixos";

  custom.flatpak.enable = true;
  custom.kdePlasma.enable = true;
  custom.pipewire.enable = true;
}
