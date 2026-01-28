{ config, lib, pkgs, ... }:

{
  options.tmux.enable = lib.mkEnableOption "tmux terminal multiplexer";

  config = lib.mkIf config.tmux.enable {
    programs.tmux = {
      enable = true;
      shell = "${pkgs.stable.fish}/bin/fish";
      mouse = true;
    };
  };
}
