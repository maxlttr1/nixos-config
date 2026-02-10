{ lib, config, pkgs, settings, ... }:

{
  options = {
    ssh.enable = lib.mkEnableOption "Enable OpenSSH server";
  };

  config = lib.mkIf config.ssh.enable {
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
      "${settings.username}".openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICxC3atnZ1iNDK1tsIV4/rfWrGTUn5VrP2wxGY1lGl5+ maxlttr@terra"
      ];
    };
  };
}
