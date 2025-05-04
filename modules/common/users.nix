{ settings, inputs, pkgs, config, ... }:

{
  users.users = {
    "${settings.username}" = {
      isNormalUser = true;
      createHome = true;
      extraGroups = ["wheel"];
      initialHashedPassword = "$y$j9T$3K3QPsozzjlkc32uJ8mVz1$X4caTQbNlRdtlGkZwS.2KJi972RmTuMEK155tEuZfVA";
      #hashedPasswordFile = config.sops.secrets.passwd.path;
      packages = with pkgs; [];
    };
  };

  security.sudo.wheelNeedsPassword = true;
  security.sudo.execWheelOnly = true;

  # Restrict access to nix daemon
  nix.settings = {
    allowed-users = [ "@wheel" ];
    trusted-users = [ "@wheel" ];
  };
}
