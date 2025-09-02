{
  hardware.enableAllFirmware = true;

  services.fwupd.enable = true; # fwupd is a simple daemon allowing you to update some devices' firmware, including UEFI for several machines

  systemd.services.fwupd-update = {
  description = "Run fwupd refresh and update";
  after = [ "network.target" ];
  wantedBy = [ "multi-user.target" ];

  serviceConfig = {
    Type = "oneshot";
    ExecStart = ''
      fwupdmgr refresh
      fwupdmgr get-updates
      fwupdmgr update
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

    # Trigger the service
    unit = "fwupd-update.service";
  };
}