{ settings, ... }:

{
  imports = [
    ../../homeManagerModules
  ];

  custom.firefox.enable = true;
  custom.fish.enable = true;
  custom.git.enable = true;
  custom.i2p-browser.enable = true;
  custom.kate.enable = true;
  custom.pkgs.enable = true;
  custom.plasmaManager.enable = true;
  custom.shellAliases.enable = true;
  custom.sops-more.enable = true;
  custom.ssh.enable = true;
  custom.tmux.enable = true;
  custom.vscode.enable = true;
  custom.xdgCustom.enable = true;
  custom.yakuake.enable = true;
}
