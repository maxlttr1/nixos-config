{ lib, config, settings, ... }:

{
  options = {
    users.enable = lib.mkEnableOption "Enable user and privilege configuration";
  };

  config = lib.mkIf config.users.enable {
    users.users = {
      "${settings.username}" = {
        isNormalUser = true;
        createHome = true;
        extraGroups = [ "wheel" ];
        hashedPasswordFile = "/home/${settings.username}/.config/sops-nix/secrets/passwd";
      };
      "root" = {
        hashedPassword = null; # Disable root login using a password 
      };
    };

    users.mutableUsers = false;

    security.sudo.wheelNeedsPassword = true;
    security.sudo.execWheelOnly = true;

    # Restrict access to nix daemon
    nix.settings = {
      allowed-users = [ "@wheel" ];
      trusted-users = [ "@wheel" ];
    };
  };
}
