{ lib, config, ... }:

{
  options = {
    fail2ban.enable = lib.mkEnableOption "Enable fail2ban intrusion prevention";
  };

  config = lib.mkIf config.fail2ban.enable {
    services.fail2ban = {
      enable = true;
      maxretry = 20;
      bantime = "10m";
      bantime-increment = {
        enable = true;
        maxtime = "168h"; # Do not ban for more than 1 week
        overalljails = true; # Calculate the bantime based on all the violations
      };
    };
  };
}
