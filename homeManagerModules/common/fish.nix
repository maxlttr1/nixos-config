{ config, lib, pkgs, ... }:

{
  options.fish.enable = lib.mkEnableOption "fish shell with plugins";

  config = lib.mkIf config.fish.enable {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        fish_config theme choose Dracula
      '';
    };

    home.packages = with pkgs.stable; [
      fishPlugins.autopair # Auto-complete matching pairs in the Fish command line
      fishPlugins.done # Automatically receive notifications when long processes finish
      fishPlugins.fifc # Fzf powers on top of fish completion engine and allows customizable completion rules
      fishPlugins.fzf # Ef-fish-ient fish keybindings for fzf
      fishPlugins.sponge # Keeps your fish shell history clean from typos
      fishPlugins.tide
      fishPlugins.z
    ];
  };
}
