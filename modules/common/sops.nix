{ pkgs, inputs, config, settings, ... }:

{   
    # See /run/secrets for the decrypted files

    sops.defaultSopsFile = ../../secrets/secrets.yaml;
    sops.defaultSopsFormat = "yaml";
    sops.age.keyFile = "/etc/sops/age/keys.txt";

    sops.secrets.passwd = {
        owner = "${settings.username}";
        #config.users.users.maxlttr.name;
    };

    sops.secrets."vpn.env" = {
        owner = "${settings.username}"; 
        path = "/home/${settings.username}/docker/vpn.env";
    };

    sops.secrets."suaps.env" = {
        owner = "${settings.username}"; 
        path = "/home/${settings.username}/docker/suaps/suaps.env";
    };

    /*sops.secrets."suaps.config" = {
        owner = "${settings.username}"; 
        path = "/home/${settings.username}/docker/suaps/config.json";
    };*/

    sops.secrets."nixos_ssh_setup.public" = {
        owner = "${settings.username}"; 
        path = "/home/${settings.username}/.ssh/nixos_ssh_setup.pub";
    };

    sops.secrets."nixos_ssh_setup.private" = {
        owner = "${settings.username}"; 
        path = "/home/${settings.username}/.ssh/nixos_ssh_setup";
    };

    sops.secrets."racknerd_ssh.public" = {
        owner = "${settings.username}"; 
        path = "/home/${settings.username}/.ssh/racknerd_ssh.pub";
    };

    sops.secrets."racknerd_ssh.private" = {
        owner = "${settings.username}"; 
        path = "/home/${settings.username}/.ssh/racknerd_ssh";
    };

    sops.secrets."discord-webhook" = {
        owner = "${settings.username}"; 
        path = "/etc/discord-webhook.conf";
    };
}