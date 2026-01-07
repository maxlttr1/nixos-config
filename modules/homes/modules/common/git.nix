{
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
}
