{ pkgs, ... }:

{
  programs.plasma = {
    enable = true;
    workspace = {
      clickItemTo = "open"; # If you liked the click-to-open default from plasma 5
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 32;
      };
      iconTheme = "Papirus-Dark";
    };
  };
}