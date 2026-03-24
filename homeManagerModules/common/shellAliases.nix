{ config, lib, ... }:

{
  options.custom.shellAliases.enable = lib.mkEnableOption "shell aliases";

  config = lib.mkIf config.custom.shellAliases.enable {
    home.shellAliases = {
      ll = "eza -l";
      la = "eza -la";
      findf = "find . -type f -name";
      findd = "find . -type d -name";
      gl = "git log --oneline --decorate --all --graph";
      autoampdl = ''
        python src/main.py --url "https://www.youtube.com/watch?v=iSC4P1i9zmE&list=PLkF8ZEu4FB1kvxIhG9jLAEauSivb5JJGD&pp=sAgC" --download-archive ~/mountedDisk/syncthing/music/ids.txt --cookies ~/mountedDisk/syncthing/music/cookies.firefox-private.txt ~/mountedDisk/syncthing/music/AutoAmpDL/
      '';
    };
  };
}
