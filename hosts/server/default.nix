{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common
    ../../modules/docker/docker-containers.nix
    ../../modules/intel.nix
    ../../modules/ld.nix
    ../../modules/samba.nix
    ../../modules/swap.nix
  ];
}
