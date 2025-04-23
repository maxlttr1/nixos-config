{ pkgs, ... }:

{
  environment.etc."nixos-upgrade.sh" = {
    text = builtins.readFile ./nixos-upgrade.sh;
    mode = "0755";  # Make the script executable
  };
  
  systemd.timers."nixos-upgrade" = {
    wantedBy = [ "timers.target" ]; # Ensures the timer starts on boot
    timerConfig = {
      OnCalendar = "weekly";
      Persistent = true; # If the system was off during the scheduled time, run it as soon as possible after boot
    };
  };

  systemd.services."nixos-upgrade" = {
    #wantedBy = [ "multi-user.target" ]; # Start this service automatically when the system is ready for users
    after = [ "network-online.target" "nss-lookup.target" ];
    requires = [ "network-online.target" "nss-lookup.target" ];
    /*path = with pkgs; [ 
      curl 
      nixos-rebuild 
      coreutils 
    ];*/
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      ExecStart = script;
    };
    #inherit script;
  };
}