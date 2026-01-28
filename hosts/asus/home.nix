{ config, pkgs, settings, ... }:

{
  imports = [
    ../../modules/homes/modules/common
    ../../modules/homes/modules/fonts.nix
    ../../modules/homes/modules/pkgs.nix
    ../../modules/homes/modules/plasma-manager.nix
    ../../modules/homes/modules/vscode.nix
    ../../modules/homes/modules/xdg.nix
  ];

  home.username = "${settings.username}";
  home.homeDirectory = "/home/${settings.username}";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
