{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-flatpak.url = "github:gmodena/nix-flatpak";
  }; 
  
  outputs = { self, nixpkgs, nix-flatpak, ... }@inputs:{
      nixosConfigurations."pc-maxlttr" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs; };
        modules = [ 
          ./configuration.nix
          nix-flatpak.nixosModules.nix-flatpak
        ];
      };
  };
}
