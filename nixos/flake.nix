{
  description = "Coucou";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    }; 

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  }; 
  
  outputs = inputs@{ self, nixpkgs, ... }:
    #let
    #  settings = {
    #    username = "maxlttr";
    #    hostname = "pc-maxlttr";
    #    system = "x86_64-linux";
    #   kernel = "linuxPackages";
    #  };
    #in
    {
      nixosConfigurations = {
        settings.hostname = 
        let
          settings = {
            username = "maxlttr";
            hostname = "pc-maxlttr";
            system = "x86_64-linux";
            kernel = "linuxPackages";
          };
        in
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs settings; };
          modules = [
            ./hosts/thinkpad
            inputs.disko.nixosModules.disko
            inputs.nix-flatpak.nixosModules.nix-flatpak
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."${settings.username}" = import ./modules/home.nix;
              home-manager.sharedModules = [ inputs.plasma-manager.homeManagerModules.plasma-manager ];
              home-manager.backupFileExtension= "backup";
            }
          ];
        };
      };
    };
}
