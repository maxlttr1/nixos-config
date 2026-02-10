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

    impermanence = {
      url = "github:nix-community/impermanence";
      inputs = {
        nixpkgs.follows = "";
        home-manager.follows = "";
      };
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
      settings = {
        username = "maxlttr";
        system = "x86_64-linux";
      };

      overlay-nixpkgs = final: prev: {
        stable = import nixpkgs-stable {
          system = settings.system;
          config.allowUnfree = true;
        };
        unstable = import nixpkgs-unstable {
          system = settings.system;
          config.allowUnfree = true;
        };
      };

      homeManagerConfig = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users."${settings.username}" = import ./hosts/terra/home.nix;
        home-manager.sharedModules = [
          inputs.plasma-manager.homeModules.plasma-manager
          inputs.sops-nix.homeManagerModules.sops
          inputs.nix-flatpak.homeManagerModules.nix-flatpak
        ];
        home-manager.backupFileExtension = "backup";
        home-manager.extraSpecialArgs = {
          settings = settings;
          inherit inputs;
        };
      };

      modulesList = [
        inputs.home-manager.nixosModules.home-manager
        inputs.disko.nixosModules.disko
        inputs.impermanence.nixosModules.impermanence
        (
          { config, pkgs, ... }: {
            nixpkgs.overlays = [
              overlay-nixpkgs
              inputs.nix-vscode-extensions.overlays.default
            ];
          }
        )
      ];

      shells = import ./shells.nix {
        inherit (import nixpkgs-stable { system = "${settings.system}"; }) pkgs;
      };
    in
    {
      nixosConfigurations = {
        terra = nixpkgs-stable.lib.nixosSystem {
          system = settings.system;
          specialArgs = { inherit inputs settings; };
          modules = [
            ./hosts/terra
            homeManagerConfig
          ] ++ modulesList;
        };

        nexus-nexus = nixpkgs-stable.lib.nixosSystem {
          system = settings.system;
          specialArgs = { inherit inputs settings; };
          modules = [
            ./hosts/nexus-nexus
            (nixpkgs-stable.lib.recursiveUpdate homeManagerConfig {
              home-manager.users."${settings.username}" = import ./hosts/nexus-nexus/home.nix;
            })
          ] ++ modulesList;
        };

        test = nixpkgs-stable.lib.nixosSystem {
          system = settings.system;
          specialArgs = { inherit inputs settings; };
          modules = [
            ./hosts/test
            (nixpkgs-stable.lib.recursiveUpdate homeManagerConfig {
              home-manager.users."${settings.username}" = import ./hosts/test/home.nix;
            })
          ] ++ modulesList;
        };
      };

      homeConfigurations = {
        laptop = inputs.home-manager-unstable.lib.homeManagerConfiguration {
          pkgs = import nixpkgs-stable {
            system = settings.system;
            config.allowUnfree = true;
            nixpkgs.overlays = [
              overlay-nixpkgs
              inputs.nix-vscode-extensions.overlays.default
              inputs.nix-firefox-addons.overlays.default
            ];
          };

          extraSpecialArgs = {
            inherit inputs;
            settings = settings;
          };

          modules = [
            ./hosts/terra/home.nix
            inputs.plasma-manager.homeModules.plasma-manager
            inputs.sops-nix.homeManagerModules.sops
            inputs.nix-flatpak.homeManagerModules.nix-flatpak
          ];
        };
      };

      devShells."${settings.system}" = shells;
    };
}
