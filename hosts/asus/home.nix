{ config, pkgs, settings, ... }:

{
  imports = [
    ../../homeManagerModules
  ];

  fonts.enable = true;
  pkgs.enable = true;
  plasmaManager.enable = true;
  vscode.enable = true;
  xdg-i2p.enable = true;
  xdgCustom.enable = true;
  yakuake.enable = true;

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
