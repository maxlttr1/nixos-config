{
  description = "Kakoukakou";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-flatpak = {
      url = "github:gmodena/nix-flatpak";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
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
            };
            # Overlay for nixpkgs-stable
            /*overlay-stable = final: prev: {
              stable = import nixpkgs {
                system = settings.system;
                config.allowUnfree = true;
              };
            };*/
            # Overlay for nixpkgs-unstable
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
                ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable inputs.nix-vscode-extensions.overlays.default ]; })
                inputs.disko.nixosModules.disko
                inputs.nix-flatpak.nixosModules.nix-flatpak
                inputs.home-manager.nixosModules.home-manager
                inputs.sops-nix.nixosModules.sops
                inputs.impermanence.nixosModules.impermanence
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users."${settings.username}" = import ./modules/homes/home.nix;
                  home-manager.sharedModules = [ inputs.plasma-manager.homeManagerModules.plasma-manager ];
                  home-manager.backupFileExtension= "backup";
                }
              ];
            };
        desktop-maxlttr = 
          let
            settings = {
              username = "maxlttr";
              hostname = "desktop-maxlttr";
              system = "x86_64-linux";
              kernel = "linuxPackages";
            };
            # Overlay for nixpkgs-stable
            /*overlay-stable = final: prev: {
              stable = import nixpkgs {
                system = settings.system;
                config.allowUnfree = true;
              };
            };*/
            # Overlay for nixpkgs-unstable
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
                ./hosts/desktop
                ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable inputs.nix-vscode-extensions.overlays.default ]; })
                inputs.disko.nixosModules.disko
                inputs.nix-flatpak.nixosModules.nix-flatpak
                inputs.home-manager.nixosModules.home-manager
                inputs.sops-nix.nixosModules.sops
                inputs.impermanence.nixosModules.impermanence
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
              kernel = "linuxPackages";
            };
            # Overlay for nixpkgs-stable
            /*overlay-stable = final: prev: {
              stable = import nixpkgs {
                system = settings.system;
                config.allowUnfree = true;
              };
            };*/
            # Overlay for nixpkgs-unstable
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
                ./hosts/server
                ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
                inputs.disko.nixosModules.disko
                inputs.sops-nix.nixosModules.sops
                inputs.impermanence.nixosModules.impermanence
              ];
            };
      };
    };
}
