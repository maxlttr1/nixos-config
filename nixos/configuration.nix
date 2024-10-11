{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/apparmor.nix
      ./modules/auto-upgrade.nix
      ./modules/cups.nix
      ./modules/experimental-features.nix
      ./modules/firewall.nix
      ./modules/flatpaks.nix
      ./modules/gamemode.nix
      #./modules/grub.nix
      ./modules/intel.nix
      ./modules/kde-plasma.nix
      #./modules/kernel-latest.nix
      ./modules/common/network-manager.nix
      ./modules/pipewire.nix
      ./modules/pkgs-base.nix
      ./modules/pkgs-pc.nix
      ./modules/podman.nix
      ./modules/ssh.nix
      ./modules/tailscale.nix
      ./modules/common/timezone-locales.nix
      ./modules/tlp.nix
      ./modules/touchpad.nix
      ./modules/common/users.nix
      ./modules/common/state-version.nix
      ./modules/common/grub.nix
      ./modules/common/kernel.nix
      ./modules.common/hostname.nix
    ];

  #networking.hostName = "pc-maxlttr";
  
# This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
