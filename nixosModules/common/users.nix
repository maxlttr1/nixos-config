{ lib, config, settings, inputs, pkgs, ... }:

{
  options = {
    users.enable = lib.mkEnableOption "Enable user and privilege configuration";
    users.mainUsername = lib.mkOption {
      description = "Create a user with this username";
      default = "maxlttr";
      type = lib.types.str;
    };
  };

  config = lib.mkIf config.users.enable {
    users.users = {
      "${config.users.mainUsername}" = {
        isNormalUser = true;
        createHome = true;
        extraGroups = [ "wheel" ];
        hashedPassword = "$y$j9T$3K3QPsozzjlkc32uJ8mVz1$X4caTQbNlRdtlGkZwS.2KJi972RmTuMEK155tEuZfVA";
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
