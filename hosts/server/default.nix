{
  imports = [
    ./hardware-configuration.nix
    ../../modules/borgbackup.nix
    ../../modules/common
    ../../modules/docker/docker-containers.nix
    ../../modules/intel.nix
    ../../modules/ld.nix
    ../../modules/powertop-autotune.nix
    ../../modules/samba.nix
    ../../modules/swap.nix
  ];
}
