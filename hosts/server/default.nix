{
  imports = [
    ./hardware-configuration.nix
    ../../modules/apparmor.nix
    ../../modules/clamav.nix
    ../../modules/common
    ../../modules/docker
    ../../modules/fail2ban.nix
    ../../modules/fish.nix
    ../../modules/intel.nix
    ../../modules/ld.nix
    ../../modules/sops.nix
    ../../modules/ssh.nix
    ../../modules/syncthing.nix
    ../../modules/tailscale.nix
  ];
}
