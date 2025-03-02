{ pkgs, inputs, config, settings, ... }:

{   
    # See /run/secrets for the decrypted files

    sops.defaultSopsFile = ../secrets/secrets.yaml;
    sops.defaultSopsFormat = "yaml";
    sops.age.keyFile = "/home/${settings.username}/.config/sops/age/keys.txt";

    sops.secrets.passwd = {
        owner = "${settings.username}";
        #config.users.users.maxlttr.name;
    };

    sops.secrets."vpn.env" = {
        owner = "${settings.username}"; 
    };

    sops.secrets."wg-easy.env" = {
        owner = "${settings.username}"; 
    };

    sops.secrets."ssh_public" = {
        owner = "${settings.username}"; 
        path = "/home/${settings.username}/.ssh/id_rsa.pub";
    };

    sops.secrets."ssh_private" = {
        owner = "${settings.username}"; 
        path = "/home/${settings.username}/.ssh/id_rsa";
    };
}