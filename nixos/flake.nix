{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    nix-flatpak.url = "github:gmodena/nix-flatpak";
  }; 
  
  outputs = { self, nixpkgs, home-manager, stylix, nix-flatpak, ... }@inputs:{
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs; };
        modules = [ 
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.maxlttr = import ./modules/home.nix;
          } 
          stylix.nixosModules.stylix
          nix-flatpak.nixosModules.nix-flatpak
        ];
      };
  };
}
