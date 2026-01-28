{ config, lib, ... }:

{
  options.shellAliases.enable = lib.mkEnableOption "shell aliases";

  config = lib.mkIf config.shellAliases.enable {
    home.shellAliases = {
      ll = "eza -l";
      la = "eza -la";
      findf = "find . -type f -name";
      findd = "find . -type d -name";
      gl = "git log --oneline --decorate --all --graph";
    };
  };
}
