{
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "maxime.lettier@protonmail.com";
        name = "Maxime";
      };
    };
    includes = [
      {
        condition = "gitdir:~/dicewars/";
        contents = {
          user.email = "maxime.lettier@etu.univ-nantes.fr";
        };
      }
    ];
  };
}