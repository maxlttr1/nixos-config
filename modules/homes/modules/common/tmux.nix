{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.stable.fish}/bin/fish";
    mouse = true;
  };
}
