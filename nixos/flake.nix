{
  description = "A nice flake";

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
      system = "x86_64-linux";
      grub-disk = "/dev/sda";
    in
    {
      nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs username grub-disk; };
        modules = [
          {
            boot.kernelPackages = nixpkgs.linuxPackages_latest;
          } 
          ./configuration.nix
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
