{
  description = "KakouKakou";

  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
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
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?ref=latest";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    /*
      nix-index-database = {
        url = "github:nix-community/nix-index-database";
        inputs.nixpkgs.follows = "nixpkgs-stable";
      };
    */
  };

  outputs =
    inputs@{
      self,
      nixpkgs-stable,
      nixpkgs-unstable,
      ...
    }:
    let
      settings = {
        username = "GabwfBjEgF";
        system = "x86_64-linux";
      };

      myNixpkgs = import nixpkgs-stable {
        system = settings.system;
        config.allowUnfree = true;
        overlays = [
          overlay-nixpkgs
          inputs.nix-vscode-extensions.overlays.default
        ];
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

      modulesList = [
        ./nixosModules
        ./disko
        inputs.home-manager.nixosModules.home-manager
        inputs.disko.nixosModules.disko
        inputs.impermanence.nixosModules.impermanence
        inputs.lanzaboote.nixosModules.lanzaboote
      ];

      mkHomeManagerConfig = homeFile: {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users."${settings.username}" = import homeFile;
          sharedModules = [
            ./homeManagerModules
            inputs.plasma-manager.homeModules.plasma-manager
            inputs.sops-nix.homeManagerModules.sops
            inputs.nix-flatpak.homeManagerModules.nix-flatpak
            /*
              inputs.nix-index-database.homeModules.default
              { programs.nix-index-database.comma.enable = true; }t
            */
          ];
          backupFileExtension = "backup";
          extraSpecialArgs = {
            inherit inputs settings;
          };
        };
      };

      mkHost = hostname: nixpkgs-stable.lib.nixosSystem {
        system = settings.system;
        pkgs = myNixpkgs;
        specialArgs = { inherit inputs settings hostname; };
        modules = [
          ./hosts/${hostname}/configuration.nix
          ./hosts/${hostname}/hardware-configuration.nix
          (mkHomeManagerConfig ./hosts/${hostname}/home.nix)
        ]
        ++ modulesList;
      };

      shells = import ./shells.nix {
        pkgs = myNixpkgs;
      };
    in
    {
      nixosConfigurations = {
        terra-terra = mkHost "terra-terra";
        nexus-nexus = mkHost "nexus-nexus";
        vm-desktop = mkHost "vm-desktop";
      };

      checks."${settings.system}" = {
        minimal = import ./tests/minimal.nix {
          inherit inputs settings self;
          pkgs = myNixpkgs;
          lib = myNixpkgs.lib;
          modules = [
            ({ ... }: {
              _module.args = {
                inherit settings inputs;
                hostname = "minimal";
              };
            })
            ./hosts/minimal/configuration.nix
            (mkHomeManagerConfig ./hosts/minimal/home.nix)
          ]
          ++ modulesList;
        };
      };

      homeConfigurations = {
        laptop = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs-stable {
            system = settings.system;
            config.allowUnfree = true;
            overlays = [
              overlay-nixpkgs
              inputs.nix-vscode-extensions.overlays.default
            ];
          };

          extraSpecialArgs = {
            inherit inputs;
            settings = settings;
          };

          modules = [
            ./homeManagerModules
            (mkHomeManagerConfig ./hosts/terra-terra/home.nix)
            inputs.plasma-manager.homeModules.plasma-manager
            inputs.sops-nix.homeManagerModules.sops
            inputs.nix-flatpak.homeManagerModules.nix-flatpak
          ];
        };
      };

      devShells."${settings.system}" = shells;
    };
}
