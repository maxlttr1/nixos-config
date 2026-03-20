{ lib, config, pkgs, settings, ... }:

{
  options = {
    custom.ssh.enable = lib.mkEnableOption "Enable OpenSSH server";
  };

  config = lib.mkIf config.custom.ssh.enable {
    # Enable the OpenSSH daemon.
    services.openssh = {
      enable = true;
      ports = [ 22 ];
      openFirewall = true;
      allowSFTP = true;
      startWhenNeeded = true;
      settings = {
        PasswordAuthentication = false;
        AllowUsers = [ "${settings.username}" ]; # Allows all users by default
        PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
        # X11Forwarding = true;
      };
    };

    #security.pam.services.sshd.googleAuthenticator.enable = true;

    users.users = {
      "${settings.username}".openssh.authorizedKeys.keyFiles = [
        /home/${settings.username}/.config/sops-nix/secrets/nixos_ssh_setup.public
      ];
    };
  };
}
