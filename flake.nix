{
  description = "KakouKakou";

  inputs = {
    nixpkgs-main.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-overlay.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    
    home-manager = {
      #url = "github:nix-community/home-manager/release-25.05";
      #inputs.nixpkgs.follows = "nixpkgs-main";
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-overlay";
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
  }; 

  outputs = inputs@{ self, nixpkgs-main, nixpkgs-overlay, ... }:
    let
      settings-default = {
        username = "maxlttr";
        hostname = "default-maxlttr";
        system = "x86_64-linux";
        kernel = "linuxPackages";
        swap = 8; # Size in Gigabytes
      };

      # Overlay for nixpkgs
      overlay-nixpkgs = final: prev: {
        alternative = import nixpkgs-overlay {
          system = settings-default.system;
          config.allowUnfree = true;
        };
      };
      
      home-manager-config = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users."${settings-default.username}" = import ./modules/homes/home.nix;
        home-manager.sharedModules = [ inputs.plasma-manager.homeModules.plasma-manager ];
        home-manager.backupFileExtension= "backup";
      };
      
      commonModules = [
        ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-nixpkgs inputs.nix-vscode-extensions.overlays.default ]; })
        inputs.disko.nixosModules.disko
        inputs.sops-nix.nixosModules.sops
      ];
      
      desktopModules = [
        home-manager-config
        inputs.nix-flatpak.nixosModules.nix-flatpak
        inputs.home-manager.nixosModules.home-manager
      ] ++ commonModules;

      shells = import ./shells.nix { inherit (import nixpkgs-overlay { system = "x86_64-linux"; }) pkgs; };
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
              nixpkgs-overlay.lib.nixosSystem {
                system = settings.system;
                specialArgs = { inherit inputs settings; };
                modules = [./hosts/asus] ++ desktopModules;
              };
        
          server-maxlttr = 
            let
              settings = settings-default // {
                hostname = "server-maxlttr";
              };
            in
              nixpkgs-main.lib.nixosSystem {
                system = settings.system;
                specialArgs = { inherit inputs settings; };
                modules = [./hosts/server] ++ commonModules;
              };          
        };

        devShells.x86_64-linux = shells;
      };
}
