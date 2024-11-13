{ pkgs, ...}:

{
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      jellyfin = {
        autoStart = true;
        hostname = "jellyfin";
        image = "lscr.io/linuxserver/jellyfin:latest";
        environment = {
          PUID="1000";
          PGID="1000";
          TZ="Etc/UTC";
          NVIDIA_VISIBLE_DEVICES="all";
        };
        volumes = [
          "/home/maxlttr/.docker/jellyfin/library:/config"
          "/home/maxlttr/Videos:/data/tvshows"
          "/home/maxlttr/Videos:/data/movies"
        ];
        ports = [
          "8096:8096"
        ];
        cmd = [
          "--runtime=nvidia"
        ];
      };

      open-webui = {
        hostname = "open-webui";
        image = "ghcr.io/open-webui/open-webui:ollama";
        cmd = [
            "--gpus=all"
            "--add-host=host.docker.internal:host-gateway"
        ];
        volumes = [
          "/home/maxlttr/.docker/open-webui:/app/backend/data"
          "/home/maxlttr/.docker/ollama:/root/.ollama"
        ];
        ports = [
          "3000:8080"
        ];
      };
    };
  };

  environment.systemPackages = [
    pkgs.nvidia-container-toolkit
  ];
}
