{
  description = "KakouKakou";

  inputs = {
    nixpkgs-main.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-overlay.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs-main";
    }; 

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs-main";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs-main";
      inputs.home-manager.follows = "home-manager";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs-main";
    };

    #impermanence.url = "github:nix-community/impermanence";

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs-main";
    };

    fancontrol-gui.url = "github:JaysFreaky/fancontrol-gui";
  }; 
  
  outputs = inputs@{ self, nixpkgs-main, nixpkgs-overlay, ... }:
    {
      nixosConfigurations = {
        asus-maxlttr = 
          let
            settings = {
              username = "maxlttr";
              hostname = "asus-maxlttr";
              system = "x86_64-linux";
              kernel = "linuxPackages";
              swap = 8; # Size in Gigabytes
            };
            # Overlay for nixpkgs
            overlay-nixpkgs = final: prev: {
              alternative = import nixpkgs-overlay {
                system = settings.system;
                config.allowUnfree = true;
              };
            };
          in
            nixpkgs-main.lib.nixosSystem {
              system = settings.system;
              specialArgs = { inherit inputs settings; };
              modules = [
                ./hosts/asus
                ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-nixpkgs inputs.nix-vscode-extensions.overlays.default ]; })
                inputs.disko.nixosModules.disko
                inputs.nix-flatpak.nixosModules.nix-flatpak
                inputs.home-manager.nixosModules.home-manager
                inputs.sops-nix.nixosModules.sops
                #inputs.impermanence.nixosModules.impermanence
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
              swap = 8; # Size in Gigabytes
            };
            # Overlay for nixpkgs
            overlay-nixpkgs = final: prev: {
              alternative = import nixpkgs-overlay {
                system = settings.system;
                config.allowUnfree = true;
              };
            };
          in
            nixpkgs-main.lib.nixosSystem {
              system = settings.system;
              specialArgs = { inherit inputs settings; };
              modules = [
                ./hosts/desktop
                ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-nixpkgs inputs.nix-vscode-extensions.overlays.default inputs.fancontrol-gui.overlays.default ]; })
                inputs.disko.nixosModules.disko
                inputs.nix-flatpak.nixosModules.nix-flatpak
                inputs.home-manager.nixosModules.home-manager
                inputs.sops-nix.nixosModules.sops
                #inputs.impermanence.nixosModules.impermanence
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
              swap = 16; # Size in Gigabytes
            };
            # Overlay for nixpkgs
            overlay-nixpkgs = final: prev: {
              alternative = import nixpkgs-overlay {
                system = settings.system;
                config.allowUnfree = true;
              };
            };
          in
            nixpkgs-main.lib.nixosSystem {
              system = settings.system;
              specialArgs = { inherit inputs settings; };
              modules = [
                ./hosts/server
                ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-nixpkgs ]; })
                inputs.disko.nixosModules.disko
                inputs.sops-nix.nixosModules.sops
                #inputs.impermanence.nixosModules.impermanence
              ];
            };
        vm-maxlttr = 
          let
            settings = {
              username = "maxlttr";
              hostname = "vm-maxlttr";
              system = "x86_64-linux";
              kernel = "linuxPackages";
              swap = 0; # Size in Gigabytes
            };
            # Overlay for nixpkgs
            overlay-nixpkgs = final: prev: {
              alternative = import nixpkgs-overlay {
                system = settings.system;
                config.allowUnfree = true;
              };
            };
          in
            nixpkgs-main.lib.nixosSystem {
              system = settings.system;
              specialArgs = { inherit inputs settings; };
              modules = [
                ./hosts/vm
                ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-nixpkgs ]; })
                inputs.disko.nixosModules.disko
                inputs.sops-nix.nixosModules.sops
                #inputs.impermanence.nixosModules.impermanence
              ];
            };
      };
    };
}
