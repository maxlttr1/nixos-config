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
}