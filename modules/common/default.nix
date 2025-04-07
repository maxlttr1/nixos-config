{
  imports = [
    ./allow-unfree.nix
    #./bootloader.nix
    ./experimental-features.nix
    ./firewall.nix
    ./hostname.nix  
    ./kernel.nix  
    ./network-manager.nix 
    ./optimise.nix
    ./pkgs-base.nix
    ./state-version.nix
    ./swap.nix
    ./timezone-locales.nix  
    ./users.nix
  ];
}
