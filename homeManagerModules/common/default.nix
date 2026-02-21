{
  imports = [
    ./commonPkgs.nix
    ./fish.nix
    ./gc.nix
    ./git.nix
    ./shellAliases.nix
    ./sops.nix
    ./ssh.nix
    ./tmux.nix
  ];

  custom.commonPkgs.enable = true;
  custom.fish.enable = true;
  custom.gc.enable = true;
  custom.git.enable = true;
  custom.shellAliases.enable = true;
  custom.sops.enable = true;
  custom.ssh.enable = true;
  custom.tmux.enable = true;
}
