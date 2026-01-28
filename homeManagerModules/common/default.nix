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

  commonPkgs.enable = true;
  fish.enable = true;
  gc.enable = true;
  git.enable = true;
  shellAliases.enable = true;
  sops.enable = true;
  ssh.enable = true;
  tmux.enable = true;
}
