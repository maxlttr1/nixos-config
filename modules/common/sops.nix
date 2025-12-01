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
        mode = "0600";
    };

    sops.secrets."nixos_ssh_setup.public" = {
        owner = "${settings.username}"; 
        path = "/home/${settings.username}/.ssh/nixos_ssh_setup.pub";
        mode = "0640";
    };

    sops.secrets."nixos_ssh_setup.private" = {
        owner = "${settings.username}"; 
        path = "/home/${settings.username}/.ssh/nixos_ssh_setup";
        mode = "0600";
    };

    sops.secrets."racknerd_ssh.public" = {
        owner = "${settings.username}"; 
        path = "/home/${settings.username}/.ssh/racknerd_ssh.pub";
        mode = "0640";
    };

    sops.secrets."racknerd_ssh.private" = {
        owner = "${settings.username}"; 
        path = "/home/${settings.username}/.ssh/racknerd_ssh";
        mode = "0600";
    };

    sops.secrets."gitlab-univ-nantes.public" = {
        owner = "${settings.username}"; 
        path = "/home/${settings.username}/.ssh/gitlab-univ-nantes.pub";
        mode = "0640";
    };
    
    sops.secrets."gitlab-univ-nantes.private" = {
        owner = "${settings.username}"; 
        path = "/home/${settings.username}/.ssh/gitlab-univ-nantes";
        mode = "0600";
    };

    sops.secrets."discord-webhook" = {
        owner = "${settings.username}"; 
        path = "/etc/discord-webhook.conf";
    };
}