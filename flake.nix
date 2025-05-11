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
        home-manager.sharedModules = [ inputs.plasma-manager.homeManagerModules.plasma-manager ];
        home-manager.backupFileExtension= "backup";
      };
      
      commonModules = [
        ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-nixpkgs inputs.nix-vscode-extensions.overlays.default inputs.fancontrol-gui.overlays.default ]; })
        inputs.disko.nixosModules.disko
        inputs.sops-nix.nixosModules.sops
      ];
      
      desktopModules = [
        home-manager-config
        inputs.nix-flatpak.nixosModules.nix-flatpak
        inputs.home-manager.nixosModules.home-manager
      ] ++ commonModules;
    in
      {
        nixosConfigurations = {
          asus-maxlttr = 
            let
              settings = settings-default // {
                hostname = "asus-maxlttr";
              };
            in
              nixpkgs-main.lib.nixosSystem {
                system = settings.system;
                specialArgs = { inherit inputs settings; };
                modules = [./hosts/asus] ++ desktopModules;
              };
          
          desktop-maxlttr = 
            let
              settings = settings-default // {
                hostname = "desktop-maxlttr";
              };
            in
              nixpkgs-main.lib.nixosSystem {
                system = settings.system;
                specialArgs = { inherit inputs settings; };
                modules = [./hosts/desktop] ++ desktopModules;
              };
          
          server-maxlttr = 
            let
              settings = settings-default // {
                hostname = "server-maxlttr";
                swap = 16;
              };
            in
              nixpkgs-main.lib.nixosSystem {
                system = settings.system;
                specialArgs = { inherit inputs settings; };
                modules = [./hosts/server] ++ commonModules;
              };
          
          vm-maxlttr = 
            let
              settings = settings-default // {
                hostname = "vm-maxlttr";
                swap = 0;
              };
            in
              nixpkgs-main.lib.nixosSystem {
                system = settings.system;
                specialArgs = { inherit inputs settings; };
                modules = [./hosts/vm] ++ commonModules;
              };
        };
      };
}
