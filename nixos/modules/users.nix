{ config, pkgs, ... }:

{
  # Additional groups to be created automatically by the system
  users.groups.guest = {};

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    maxlttr = {
      isNormalUser = true;
      description = "Maxime Lettier";
      createHome = true;
      extraGroups = [ "networkmanager" "wheel" ];
      hashedPassword = "$y$j9T$6TwmToZanSqm1UVXXVkYc.$C35LtiPxiVzVXhZW1GpGWAVG9bKhAA3B2tvSM60Q.eC";
      packages = with pkgs; [
      ];
    };
    guest = {
      isSystemUser = true;
      group = "guest";
      hashedPassword = "$y$j9T$C.hdJNazMc6Ny3iZbIx0Z1$M1spP1E6rPPALuNFAKmOCT0TkDe8upj.TIlnI7xMNb4";
    };  
  };

  security.sudo.wheelNeedsPassword = true;
  security.sudo.execWheelOnly = true;

  # Restrict access to nix daemon
  nix.settings.allowed-users = [ "@wheel" ];
}
