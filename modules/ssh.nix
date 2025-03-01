{ config, pkgs, settings, ... }:

{
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    openFirewall = true;
    allowSFTP = true;
    startWhenNeeded = true;
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "${settings.username}" ]; # Allows all users by default. Can be [ "user1" "user2" ]
      PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  }; 

  #security.pam.services.sshd.googleAuthenticator.enable = true;
}
