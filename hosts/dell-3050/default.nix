{
  imports = [
    #./hardware-configuration.nix
    ./disko.nix
    ../../modules/apparmor.nix
    ../../modules/intel.nix
    ../../modules/pkgs.nix
    ../../modules/podman.nix
    ../../modules/ssh.nix
    ../../modules/tailscale.nix
    ../../modules/virt-manager.nix
    ../../modules/common
  ];
}