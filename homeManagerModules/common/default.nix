{
  imports = [
    ./commonPkgs.nix
    ./gc.nix
    ./general.nix
    ./sops.nix
  ];

  custom.commonPkgs.enable = true;
  # custom.gc.enable = true;
  custom.sops.enable = true;
}
