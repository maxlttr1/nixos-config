{ lib, config, settings, ... }:

{
  options = {
    custom.users.enable = lib.mkEnableOption "Enable user and privilege configuration";
  };

  config = lib.mkIf config.custom.users.enable {
    users.users = {
      "${settings.username}" = {
        isNormalUser = true;
        createHome = true;
        extraGroups = [ "wheel" ];
        hashedPassword = "$y$j9T$cVaStq4nQnBE2Iz3wrZIM1$UdvZmv2wmvy93xnNl4h403DI30v8G8satfg4r0.vN9.";
      };
      "maxlttr" = {
        isNormalUser = true;
        createHome = true;
        extraGroups = [ "wheel" ];
        hashedPassword = "$y$j9T$cVaStq4nQnBE2Iz3wrZIM1$UdvZmv2wmvy93xnNl4h403DI30v8G8satfg4r0.vN9.";
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
