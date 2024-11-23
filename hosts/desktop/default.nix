{ lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ../../modules/bluetooth.nix
    ../../modules/clamav.nix
    ../../modules/cups.nix
    #../../modules/docker.nix
    #../../modules/docker-containers.nix
    ../../modules/firejail.nix
    ../../modules/gamemode.nix
    ../../modules/kde-plasma.nix
    ../../modules/nvidia.nix
    ../../modules/pipewire.nix
    ../../modules/pkgs.nix
    #../../modules/pkgs-gaming.nix
    ../../modules/ssh.nix
    ../../modules/syncthing.nix
    ../../modules/tailscale.nix
    ../../modules/touchpad.nix
    ../../modules/virt-manager.nix
    ../../modules/common
  ];

  boot.resumeDevice = lib.mkDefault "/dev/sda"; #if not, the 2 swap are in conflict to resume the device
}
