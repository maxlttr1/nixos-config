{ pkgs, ... }:

{
  hardware.enableAllFirmware = true;

  services.fwupd.enable = true; # fwupd is a simple daemon allowing you to update some devices' firmware, including UEFI for several machines

  /*
    systemd.services.fwupd-update = {
    description = "Run fwupd refresh and update";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
    Type = "oneshot";
    ExecStart = ''
      ${pkgs.fwupd}/bin/fwupdmgr refresh
      ${pkgs.fwupd}/bin/fwupdmgr get-updates
      ${pkgs.fwupd}/bin/fwupdmgr update
    '';
    };
    };

    systemd.timers.fwupd-update = {
    description = "Periodically refresh and apply fwupd updates";
    wantedBy = [ "timers.target" ];

    timerConfig = {
      OnCalendar = "weekly";
      Persistent = true;
    };
    };
  */
}
