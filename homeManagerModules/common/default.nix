{
  imports = [
    ./commonPkgs.nix
    ./fish.nix
    ./gc.nix
    ./general.nix
    ./sops.nix
    ./shellAliases.nix
  ];

  custom.commonPkgs.enable = true;
  custom.fish.enable = true;
  # custom.gc.enable = true;
  custom.sops.enable = true;
  custom.shellAliases.enable = true;
}
