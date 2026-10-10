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
      create-ubuntu = "docker build --no-cache --build-arg UID=$(id -u) --build-arg USERNAME=$(id -un) -t custom-ubuntu $HOME/Documents/nixos-config/nixosModules/common/docker/inactive/ubuntu/";
      run-ubuntu = "docker run -it --rm -u $(id -u):$(id -g) -v \"$HOME/:/home/$(id -un)/\" -w /home/$(id -un) custom-ubuntu /bin/bash";
      ssh-vps = "ssh root@$(cat ${config.sops.secrets."racknerd_ip".path}) -i ${
        config.sops.secrets."racknerd_ssh.private".path
      }";
      music-download-no-cookies = "nix run nixpkgs/nixpkgs-unstable#yt-dlp -- \"https://www.youtube.com/watch?v=AQ6iA-0CRL8&list=PLkF8ZEu4FB1kvxIhG9jLAEauSivb5JJGD\" --playlist-items 1:100 -f bestaudio --remux-video opus --embed-metadata --embed-thumbnail -o \"$HOME/mountedDisk/syncthing/music/New/%(title)s [%(id)s].%(ext)s\" --download-archive \"$HOME/mountedDisk/syncthing/music/downloaded.txt\"";
      music-download = "music-download-no-cookies --cookies  \"$HOME/mountedDisk/syncthing/music/cookies.firefox-private.txt\"";
      music-normalize = "${pkgs.rsgain}/bin/rsgain easy -p no_album --skip-existing \"$HOME/mountedDisk/syncthing/music/\"";
      music-full-no-cookies = "music-download-no-cookies; music-normalize";
      music-full = "music-download; music-normalize";
      backup-syncthing = "tar cf - /home/${settings.username}/mountedDisk/syncthing | zstd -T0 | ${pkgs.age}/bin/age -p > /home/${settings.username}/mountedDisk/syncthing-backup-$(date +%d-%m-%Y).tar.zst.age";
    };
  };
}
