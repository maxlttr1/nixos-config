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
    {
      nixosConfigurations = {
        thinkpad = 
          let
            settings = {
              username = "maxlttr";
              hostname = "pc-maxlttr";
              system = "x86_64-linux";
              kernel = "linuxPackages";
            };
            specialArgs = { inherit inputs settings; };
          in
            nixpkgs.lib.nixosSystem {
              modules = [
                ./hosts/thinkpad
                inputs.disko.nixosModules.disko
                inputs.nix-flatpak.nixosModules.nix-flatpak
                inputs.home-manager.nixosModules.home-manager
                {
                  networking.hostName = settings.hostname;
                }
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
