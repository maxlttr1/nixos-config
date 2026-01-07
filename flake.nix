{
  description = "KakouKakou";

  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    disko-stable = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    disko-unstable = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.home-manager.follows = "home-manager-unstable";
    };

    sops-nix-stable = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    sops-nix-unstable = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
	
    nix-firefox-addons = {
      url = "github:osipog/nix-firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nvf-stable = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    nvf-unstable = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
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
          inputs.sops-nix-unstable.homeManagerModules.sops
          inputs.nvf-unstable.homeManagerModules.default
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
          inputs.sops-nix-stable.homeManagerModules.sops
          inputs.nvf-stable.homeManagerModules.default
        ];
        home-manager.backupFileExtension = "backup";
        home-manager.extraSpecialArgs = {
          settings = settings-default;
          inherit inputs;
        };
      };

      shells = import ./shells.nix {
        inherit (import nixpkgs-unstable { system = "x86_64-linux"; }) pkgs;
      };
    in
    {
      nixosConfigurations = {
        asus-maxlttr =
          let
            settings = settings-default // {
              hostname = "asus-maxlttr";
              kernel = "linuxPackages_latest";
            };
          in
          nixpkgs-unstable.lib.nixosSystem {
            system = settings.system;
            specialArgs = { inherit inputs settings; };
            modules = [
              ./hosts/asus
              home-manager-config
              inputs.home-manager-unstable.nixosModules.home-manager
              inputs.disko-unstable.nixosModules.disko
              (
                { config, pkgs, ... }: { nixpkgs.overlays = [
                    overlay-nixpkgs
                    inputs.nix-vscode-extensions.overlays.default
                    inputs.nix-firefox-addons.overlays.default
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
              inputs.home-manager-stable.nixosModules.home-manager
              inputs.disko-stable.nixosModules.disko
			  ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-nixpkgs ]; })
            ];
          };
      };

      homeConfigurations = {
        laptop = inputs.home-manager-unstable.lib.homeManagerConfiguration {
          pkgs = import nixpkgs-unstable {
            system = settings-default.system;
            config.allowUnfree = true;
          };

          extraSpecialArgs = {
            inherit inputs;
            settings = settings-default;
          };

          modules = [
            ./modules/homes/laptop.nix
            inputs.plasma-manager.homeModules.plasma-manager
            inputs.sops-nix-unstable.homeManagerModules.sops
            inputs.nvf-unstable.homeManagerModules.default
            (
              { config, pkgs, ... }: { nixpkgs.overlays = [ 
                inputs.nix-vscode-extensions.overlays.default
                inputs.nix-firefox-addons.overlays.default
              ];
              }
            )
          ];
        };
      };

      devShells.x86_64-linux = shells;
    };
}
