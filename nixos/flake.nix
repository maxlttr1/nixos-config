{
  description = "A nice flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.4.1";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };  
  }; 
  
  outputs = inputs@{ self, nixpkgs, home-manager, nix-flatpak, ... }:
    let
      username = "maxlttr";
      hostname = "pc-maxlttr";
      system = "x86_64-linux";
      grub-disk = "/dev/sda";
      kernel = "linuxPackages";
    in
    {
      nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs username hostname grub-disk kernel; };
        modules = [
          ./configuration.nix
          nix-flatpak.nixosModules.nix-flatpak
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."${username}" = import ./modules/home.nix;
            home-manager.backupFileExtension= "backup";
          }
        ];
      };
  };
}
