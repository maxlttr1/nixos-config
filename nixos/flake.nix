{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };  
  }; 
  
  outputs = inputs@{ self, nixpkgs, home-manager, nix-flatpak, ... }:
    let
      username = "maxlttr";
      hostname = "pc-maxlttr";
      # Replace with the fitting architecture
      system = "x86_64-linux";
      grub-disk = "/dev/sda";
    in
    {
      nixosConfigurations."pc-maxlttr" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs username; };
        modules = [ 
          ./configuration.nix
          {
            networking.hostName = "${hostname}";
#            boot.loader.grub.enable = true;        # Enable GRUB
#            boot.loader.grub.devices = [ "${grub-disk}" ];  # Device for GRUB installation
#            boot.loader.grub.useOSProber = true;   # Enable OS detection
#            boot.loader.grub.configurationLimit = 10;
          }
          nix-flatpak.nixosModules.nix-flatpak
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."${username}" = import ./modules/home.nix;
            home-manager.backupFileExtension= "backup";
          }
        ];
      };
  };
}
