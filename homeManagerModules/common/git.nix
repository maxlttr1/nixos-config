{ config, lib, ... }:

{
  options.custom.git.enable = lib.mkEnableOption "git configuration";

  config = lib.mkIf config.custom.git.enable {
    programs.git = {
      enable = true;
      settings = {
        user.email = "maxime.lettier@protonmail.com";
        user.name = "Maxime LETTIER";
      };
      includes = [
        {
          condition = "gitdir:~/polytech_projects/";
          contents = {
            user.email = "maxime.lettier@etu.univ-nantes.fr";
            user.name = "Maxime LETTIER";
          };
        }
      ];
    };
  };
}
