{ settings, inputs, pkgs, config, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    "${settings.username}" = {
      isNormalUser = true;
      createHome = true;
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "docker" "syncthing" ];
      #initialHashedPassword = "$y$j9T$3K3QPsozzjlkc32uJ8mVz1$X4caTQbNlRdtlGkZwS.2KJi972RmTuMEK155tEuZfVA";
      hashedPasswordFile = config.sops.secrets.passwd.path;
      packages = with pkgs; [
      ];
    };
  };

  security.sudo.wheelNeedsPassword = true;
  security.sudo.execWheelOnly = true;

  # Restrict access to nix daemon
  nix.settings.allowed-users = [ "@wheel" ];
}
