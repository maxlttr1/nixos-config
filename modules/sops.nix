{ pkgs, inputs, config, settings, ... }:

{   
    # See /run/secrets for the decrypted files

    sops.defaultSopsFile = ../secrets/secrets.yaml;
    sops.defaultSopsFormat = "yaml";
    sops.age.keyFile = "/etc/sops/keys.txt";

    sops.secrets.passwd = {
        #neededForUsers = true;
        owner = "${settings.username}"
        #config.users.users.maxlttr.name;
    };

    sops.secrets."vpn.env" = {
        owner = "${settings.username}"; 
        #config.users.users.maxlttr.name;
        #path = "${config.home.homeDirectory}/.secrets/vpn/WIREGUARD_ADDRESSES";
        # owenr = config.users.users.maxlttr.name;
    };
}