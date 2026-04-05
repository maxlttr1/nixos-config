{ config, lib, settings, ... }:

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
      create-ubuntu = ''
		docker build  \
			--no-cache \
			--build-arg UID=$(id -u) \
			--build-arg USERNAME=$(id -un) \
			-t custom-ubuntu \
			$HOME/Documents/nixos-config/nixosModules/common/docker/inactive/ubuntu/
	  '';
      run-ubuntu = ''
        docker run -it --rm \
			-u $(id -u):$(id -g) \
			-v "$HOME/Documents/:/home/$(id -un)/Documents:ro" \
			-v "$HOME/mountedDisk/syncthing/:/home/$(id -un)/syncthing:ro" \
			-w /home/$(id -un) \
			custom-ubuntu /bin/bash
      '';
    };
  };
}
