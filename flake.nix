{
  description = "KakouKakou";

  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs-stable";
      inputs.home-manager.follows = "home-manager";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
    };

    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?ref=latest";
    };
  };

  outputs = inputs@{ self, nixpkgs-stable, nixpkgs-unstable, ... }:
    let
      settings-default = {
        username = "maxlttr";
        hostname = "default-maxlttr";
        system = "x86_64-linux";
        kernel = "linuxPackages";
        swap = 8; # Size in Gigabytes
      };

      overlay-nixpkgs = final: prev: {
        stable = import nixpkgs-stable {
          system = settings-default.system;
          config.allowUnfree = true;
        };
        unstable = import nixpkgs-unstable {
          system = settings-default.system;
          config.allowUnfree = true;
        };
      };

      home-manager-config = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users."${settings-default.username}" = import ./modules/homes/laptop.nix;
        home-manager.sharedModules = [
          inputs.plasma-manager.homeModules.plasma-manager
          inputs.sops-nix.homeManagerModules.sops
          inputs.nix-flatpak.homeManagerModules.nix-flatpak
        ];
        home-manager.backupFileExtension = "backup";
        home-manager.extraSpecialArgs = {
          settings = settings-default;
          inherit inputs;
        };
      };

      home-manager-config-server = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users."${settings-default.username}" = import ./modules/homes/server.nix;
        home-manager.sharedModules = [
          inputs.sops-nix.homeManagerModules.sops
        ];
        home-manager.backupFileExtension = "backup";
        home-manager.extraSpecialArgs = {
          settings = settings-default;
          inherit inputs;
        };
      };

      shells = import ./shells.nix {
        inherit (import nixpkgs-stable { system = "x86_64-linux"; }) pkgs;
      };
    in
    {
      nixosConfigurations = {
        asus-maxlttr =
          let
            settings = settings-default // {
              hostname = "asus-maxlttr";
            };
          in
          nixpkgs-stable.lib.nixosSystem {
            system = settings.system;
            specialArgs = { inherit inputs settings; };
            modules = [
              ./hosts/asus
              home-manager-config
              inputs.home-manager.nixosModules.home-manager
              inputs.disko.nixosModules.disko
              (
                { config, pkgs, ... }: {
                  nixpkgs.overlays = [
                    overlay-nixpkgs
                    inputs.nix-vscode-extensions.overlays.default
                  ];
                }
              )
            ];
          };

        server-maxlttr =
          let
            settings = settings-default // {
              hostname = "server-maxlttr";
            };
          in
          nixpkgs-stable.lib.nixosSystem {
            system = settings.system;
            specialArgs = { inherit inputs settings; };
            modules = [
              ./hosts/server
              home-manager-config-server
              inputs.home-manager.nixosModules.home-manager
              inputs.disko.nixosModules.disko
              ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-nixpkgs ]; })
            ];
          };
      };

      homeConfigurations = {
        laptop = inputs.home-manager-unstable.lib.homeManagerConfiguration {
          pkgs = import nixpkgs-stable {
            system = settings-default.system;
            config.allowUnfree = true;
            nixpkgs.overlays = [
              overlay-nixpkgs
              inputs.nix-vscode-extensions.overlays.default
              inputs.nix-firefox-addons.overlays.default
            ];
          };

          extraSpecialArgs = {
            inherit inputs;
            settings = settings-default;
          };

          modules = [
            ./modules/homes/laptop.nix
            inputs.plasma-manager.homeModules.plasma-manager
            inputs.sops-nix.homeManagerModules.sops
            inputs.nix-flatpak.homeManagerModules.nix-flatpak
          ];
        };
      };

      devShells.x86_64-linux = shells;
    };
}
