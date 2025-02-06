{ pkgs, inputs, config, settings, ... }:

{
    imports = [
        inputs.sops-nix.nixosModules.sops
    ];

    # See /run/secrets for the decrypted files

    sops.defaultSopsFile = ../secrets/secrets.yaml;
    sops.defaultSopsFormat = "yaml";
    sops.age.keyFile = "/home/${settings.username}/.config/sops/age/keys.txt";

    sops.secrets.passwd = {
        #neededForUsers = true;
        owner = config.users.users.maxlttr.name;
    };
    sops.secrets."myservice/mysubdir/mysecret" = {};
}