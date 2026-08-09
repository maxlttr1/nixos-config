{
  config,
  lib,
  pkgs,
  settings,
  ...
}:

{
  options.custom.shellAliases.enable = lib.mkEnableOption "shell aliases";

  config = lib.mkIf config.custom.shellAliases.enable {
    home.shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      findf = "find . -type f -name";
      findd = "find . -type d -name";
      gl = "git log --oneline --decorate --all --graph";
      autoampdl = "python src/main.py --url \"https://www.youtube.com/watch?v=iSC4P1i9zmE&list=PLkF8ZEu4FB1kvxIhG9jLAEauSivb5JJGD&pp=sAgC\" --download-archive ~/mountedDisk/syncthing/music/ids.txt --cookies ~/mountedDisk/syncthing/music/cookies.firefox-private.txt ~/mountedDisk/syncthing/music/AutoAmpDL/";
      create-ubuntu = "docker build --no-cache --build-arg UID=$(id -u) --build-arg USERNAME=$(id -un) -t custom-ubuntu $HOME/Documents/nixos-config/nixosModules/common/docker/inactive/ubuntu/";
      run-ubuntu = "docker run -it --rm -u $(id -u):$(id -g) -v \"$HOME/:/home/$(id -un)/\" -w /home/$(id -un) custom-ubuntu /bin/bash";
      ssh-vps = "ssh root@$(cat /home/${settings.username}/.config/sops-nix/secrets/racknerd_ip) -i /home/${settings.username}/.config/sops-nix/secrets/racknerd_ssh.private";
      music-download = "${pkgs.yt-dlp}/bin/yt-dlp \"https://www.youtube.com/watch?v=AQ6iA-0CRL8&list=PLkF8ZEu4FB1kvxIhG9jLAEauSivb5JJGD\" --playlist-items 1:100 -f bestaudio --remux-video opus --embed-metadata --embed-thumbnail -o \"$HOME/mountedDisk/syncthing/music/New/%(title)s [%(id)s].%(ext)s\" --download-archive \"$HOME/mountedDisk/syncthing/music/downloaded.txt\" --cookies  \"$HOME/mountedDisk/syncthing/music/cookies.firefox-private.txt\"";
      music-normalize = "${pkgs.rsgain}/bin/rsgain easy -p no_album --skip-existing \"$HOME/mountedDisk/syncthing/music/\"";
      music-full = "music-download && music-normalize";
    };
  };
}
