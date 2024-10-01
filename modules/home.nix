{ config, pkgs, ... }:

{
  home.username = "maxlttr";
  home.homeDirectory = "/home/maxlttr";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    librewolf.settings = {
        "middlemouse.paste" = false;
        "general.autoScroll" = true;
    };

    git = {
      enable = true;
      userEmail = "maxime.lettier@protonmail.com";
      userName = "maxlttr1";  
    };
  };

  home.packages = [
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

}
