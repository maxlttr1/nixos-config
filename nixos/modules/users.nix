{ username, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    "${username}" = {
      isNormalUser = true;
      createHome = true;
      extraGroups = [ "networkmanager" "wheel" ];
      initialhashedPassword = "$y$j9T$FNklRaiyPvHgR8ueH12z2/$q8k1QXd/CIbwQqV8rdEzGeAOVVL3N9cBa1pP4zyz0m8";
      packages = with pkgs; [
      ];
    };
  };

  security.sudo.wheelNeedsPassword = true;
  security.sudo.execWheelOnly = true;

  # Restrict access to nix daemon
  nix.settings.allowed-users = [ "@wheel" ];
}
