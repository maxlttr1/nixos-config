{ config, lib, pkgs, ... }:

{
  options.custom.tmux.enable = lib.mkEnableOption "tmux terminal multiplexer";

  config = lib.mkIf config.custom.tmux.enable {
    programs.tmux = {
      enable = true;
      shell = "${pkgs.fish}/bin/fish";
      mouse = true;
    };
  };
}
