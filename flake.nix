{
  description = "Coucou";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

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

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-mineral = {
      url = "github:cynicsketch/nix-mineral"; # Refers to the main branch and is updated to the latest commit when you use "nix flake update" 
      # url = "github:cynicsketch/nix-mineral/v0.1.6-alpha" # Refers to a specific tag and follows that tag until you change it 
      # url = "github:cynicsketch/nix-mineral/cfaf4cf15c7e6dc7f882c471056b57ea9ea0ee61" # Refers to a specific commit and follows that until you change it 
      flake = false;
    };
  }; 
  
  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, ... }:
    {
      nixosConfigurations = {
        asus-maxlttr = 
          let
            settings = {
              username = "maxlttr";
              hostname = "asus-maxlttr";
              system = "x86_64-linux";
              kernel = "linuxPackages";
              disk = "/dev/nvme0n1";
            };
            overlay-unstable = final: prev: {
              unstable = import nixpkgs-unstable {
                system = settings.system;
                config.allowUnfree = true;
              };
            };
          in
            nixpkgs.lib.nixosSystem {
              system = settings.system;
              specialArgs = { inherit inputs settings; };
              modules = [
                ./hosts/asus
                ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
                #inputs.disko.nixosModules.disko
                inputs.nix-flatpak.nixosModules.nix-flatpak
                inputs.home-manager.nixosModules.home-manager
                inputs.sops-nix.nixosModules.sops
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users."${settings.username}" = import ./modules/homes/home.nix;
                  home-manager.sharedModules = [ inputs.plasma-manager.homeManagerModules.plasma-manager ];
                  home-manager.backupFileExtension= "backup";
                }
              ];
            };
        server-maxlttr = 
          let
            settings = {
              username = "maxlttr";
              hostname = "server-maxlttr";
              system = "x86_64-linux";
              kernel = "linuxPackages_hardened";
              disk = "/dev/sda";
            };
            overlay-unstable = final: prev: {
              unstable = import nixpkgs-unstable {
                system = settings.system;
                config.allowUnfree = true;
              };
            };
          in
            nixpkgs.lib.nixosSystem {
              system = settings.system;
              specialArgs = { inherit inputs settings; };
              modules = [
                ./hosts/asus
                ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
                #inputs.disko.nixosModules.disko
                #inputs.nix-flatpak.nixosModules.nix-flatpak
                #inputs.home-manager.nixosModules.home-manager
                inputs.sops-nix.nixosModules.sops
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users."${settings.username}" = import ./modules/homes/home-server.nix;
                  home-manager.sharedModules = [ inputs.plasma-manager.homeManagerModules.plasma-manager ];
                  home-manager.backupFileExtension= "backup";
                }
              ];
            };
      };
    };
}
