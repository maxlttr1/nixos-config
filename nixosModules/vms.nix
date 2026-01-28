{ lib, config, pkgs, ... }:

{
  options = {
    vms.enable = lib.mkEnableOption "Enable virtual machine support";
  };

  config = lib.mkIf config.vms.enable {
    # Virt-manager
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;

    users.groups.libvirtd.members = [ "${config.users.mainUsername}" ];
    users.users."${config.users.mainUsername}".extraGroups = [ "libvirtd" ];

    services.qemuGuest.enable = true;
    services.spice-vdagentd.enable = true; # enable copy and paste between host and guest

    # Quickemu
    environment.systemPackages =
      (with pkgs; [
        quickgui
        quickemu
      ])
      ++
      (with pkgs.alternative; [
      ]);
  };
}
