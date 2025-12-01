{
  imports = [
    ./hardware-configuration.nix
    ../../modules/borgbackup.nix
    ../../modules/common
    ../../modules/intel.nix
    ../../modules/powertop-autotune.nix
    ../../modules/swap.nix
  ];
}
