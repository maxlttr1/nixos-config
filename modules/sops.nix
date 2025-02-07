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
    sops.age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";

    sops.secrets.passwd = {
        #neededForUsers = true;
        owner = config.users.users.maxlttr.name;
    };

    sops.secrets."vpn/WIREGUARD_ADDRESSES" = {
        owner = "vpn_stack-gluetun";
        #path = "${config.home.homeDirectory}/.secrets/vpn/WIREGUARD_ADDRESSES";
        # owenr = config.users.users.maxlttr.name;
    };
    sops.secrets."vpn/WIREGUARD_ENDPOINT_IP" = {
        owner = "vpn_stack-gluetun";
    };
    sops.secrets."vpn/WIREGUARD_ENDPOINT_PORT" = {
        owner = "vpn_stack-gluetun";
    };
    sops.secrets."vpn/WIREGUARD_PRESHARED_KEY" = {
        owner = "vpn_stack-gluetun";
    };
    sops.secrets."vpn/WIREGUARD_PRIVATE_KEY" = {
        owner = "vpn_stack-gluetun";
    };
    sops.secrets."vpn/WIREGUARD_PUBLIC_KEY" = {
        owner = "vpn_stack-gluetun";
    };

    
}