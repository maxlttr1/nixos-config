{ pkgs, inputs, config, settings, ... }:

{   
    # See /run/secrets for the decrypted files

    /*let
    userExists = builtins.pathExists "/home/${settings.username}";
    in
        {
        sops.age.keyFile = if userExists then "/home/${settings.username}/.config/sops/age/keys.txt" else "/etc/sops/age/keys.txt";
        }*/


    sops.defaultSopsFile = ../secrets/secrets.yaml;
    sops.defaultSopsFormat = "yaml";
    sops.age.keyFile = "/etc/sops/keys.txt";

    sops.secrets.passwd = {
        #neededForUsers = true;
        owner = config.users.users.maxlttr.name;
    };

    sops.secrets."vpn.env" = {
        owner = config.users.users.maxlttr.name;
        #path = "${config.home.homeDirectory}/.secrets/vpn/WIREGUARD_ADDRESSES";
        # owenr = config.users.users.maxlttr.name;
    };
    /*
    sops.secrets."vpn/WIREGUARD_ADDRESSES" = {
        owner = config.users.users.maxlttr.name;
        #path = "${config.home.homeDirectory}/.secrets/vpn/WIREGUARD_ADDRESSES";
        # owenr = config.users.users.maxlttr.name;
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

    sops.templates."vpn/WIREGUARD_ADDRESSES" = {
        content = ''
            "${config.sops.placeholder."vpn/WIREGUARD_ADDRESSES"}"
        '';
        owner = config.users.users.maxlttr.name;
    };

    sops.templates."vpn/WIREGUARD_ENDPOINT_IP" = {
        content = ''
            "${config.sops.placeholder."vpn/WIREGUARD_ENDPOINT_IP"}"
        '';
        owner = config.users.users.maxlttr.name;
    };

    sops.templates."vpn/WIREGUARD_ENDPOINT_PORT" = {
        content = ''
            "${config.sops.placeholder."vpn/WIREGUARD_ENDPOINT_PORT"}"
        '';
        owner = config.users.users.maxlttr.name;
    };

    sops.templates."vpn/WIREGUARD_PRESHARED_KEY" = {
        content = ''
            "${config.sops.placeholder."vpn/WIREGUARD_PRESHARED_KEY"}"
        '';
        owner = config.users.users.maxlttr.name;
    };

    sops.templates."vpn/WIREGUARD_PRIVATE_KEY" = {
        content = ''
            "${config.sops.placeholder."vpn/WIREGUARD_PRIVATE_KEY"}"
        '';
        owner = config.users.users.maxlttr.name;
    };

    sops.templates."vpn/WIREGUARD_PUBLIC_KEY" = {
        content = ''
            "${config.sops.placeholder."vpn/WIREGUARD_PUBLIC_KEY"}"
        '';
        owner = config.users.users.maxlttr.name;
    };
    */
}