{ pkgs, ... }:

let
  starting_script = pkgs.writeShellScript "starting_script" ''
    if [ ! -d "nixos-config" ]; then
      ${pkgs.git}/bin/git clone https://github.com/maxlttr1/nixos-config.git
    fi
    cd nixos-config/
    ${pkgs.git}/bin/git checkout docker_rebase

    files=$(ls ./modules/docker/ymls)
    echo "Files in current directory: $files"

    for entry in $(ls ./modules/docker/ymls/); do
      ${pkgs.docker}/bin/docker compose -p $entry -f ./modules/docker/ymls/$entry.yml up -d
    done

    cd..
    rm -r nixos-config/
  ''; 
in

{
  /*imports = [
    ./deluge/deluge.nix
    ./jellyfin/jellyfin.nix
    ./n8n/n8n.nix
    ./portainer/portainer.nix
    ./traefik/traefik.nix
    ./uptime-kuma/uptime-kuma.nix
    ./watchtower/watchtower.nix
  ];*/

  # Run with compose2nix: compose2nix -inputs input.yml -output output.nix -runtime docker

  /*
  environment = {
      "VPN_SERVICE_PROVIDER" = "custom";
      "VPN_TYPE" = "wireguard";
  };
  environmentFiles = [ config.sops.secrets."vpn.env".path ];
  */

  systemd.services."docker-containers-management" = {
    description = "Manage Docker containers";

    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      WorkingDirectory = "/tmp/";

      ExecStart = "${starting_script}";
      #ExecStop = "${stoping_script}";
      #ExecReload = "${reloading_script}";
    };
  };
}
