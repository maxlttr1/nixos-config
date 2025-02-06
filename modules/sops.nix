{ pkgs, inputs, config, settings, ... }:

{   
    # See /run/secrets for the decrypted files

    sops.defaultSopsFile = ../secrets/secrets.yaml;
    sops.defaultSopsFormat = "yaml";
    sops.age.keyFile = "/home/${settings.username}/.config/sops/age/keys.txt";

    sops.secrets.passwd = {
        #neededForUsers = true;
        owner = config.users.users.maxlttr.name;
    };

    sops.secrets."vpn/WIREGUARD_ADDRESSES" = {
        owner = config.users.users.maxlttr.name;
    };
    sops.secrets."vpn/WIREGUARD_ENDPOINT_IP" = {
        owner = config.users.users.maxlttr.name;
    };
    sops.secrets."vpn/WIREGUARD_ENDPOINT_PORT" = {
        owner = config.users.users.maxlttr.name;
    };
    sops.secrets."vpn/WIREGUARD_PRESHARED_KEY" = {
        owner = config.users.users.maxlttr.name;
    };
    sops.secrets."vpn/WIREGUARD_PRIVATE_KEY" = {
        owner = config.users.users.maxlttr.name;
    };
    sops.secrets."vpn/WIREGUARD_PUBLIC_KEY" = {
        owner = config.users.users.maxlttr.name;
    };
}