{ config, pkgs, settings, ... }:

{
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "${settings.username}" ]; # Allows all users by default. Can be [ "user1" "user2" ]
      PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
      KbdInteractiveAuthentication = false; #Specifies whether keyboard-interactive authentication is allowed
    };
  }; 

  #security.pam.services.sshd.googleAuthenticator.enable = true;
}
