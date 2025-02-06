{ pkgs, inputs, config, settings, ... }:

{
    imports = [
        inputs.sops-nix.nixosModules.sops
    ];

    # See /run/secrets for the decrypted files

    sops.defaultSopsFile = "../secrets/test.yaml";
    sops.defaultSopsFormat = "yaml";
    sops.age.keyFile = "/home/maxlttr/.config/sops/age/keys.txt";

    sops.secrets.passwd = {
        neededForUsers = true;
    };
    sops.secrets."myservice/mysubdir/mysecret" = {};
}