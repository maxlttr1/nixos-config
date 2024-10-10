{ username, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    "${username}" = {
      isNormalUser = true;
      createHome = true;
      extraGroups = [ "networkmanager" "wheel" ];
      hashedPassword = "$y$j9T$6TwmToZanSqm1UVXXVkYc.$C35LtiPxiVzVXhZW1GpGWAVG9bKhAA3B2tvSM60Q.eC";
      packages = with pkgs; [
      ];
    };
  };

  security.sudo.wheelNeedsPassword = true;
  security.sudo.execWheelOnly = true;

  # Restrict access to nix daemon
  nix.settings.allowed-users = [ "@wheel" ];
}
