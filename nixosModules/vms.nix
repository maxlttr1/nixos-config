{ lib, config, settings, pkgs, ... }:

{
  options = {
    custom.vms.enable = lib.mkEnableOption "Enable virtual machine support";
  };

  config = lib.mkIf config.custom.vms.enable {
    # Virt-manager
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;

    users.groups.libvirtd.members = [ "${settings.username}" ];
    users.users.${settings.username}.extraGroups = [ "libvirtd" ];

    services.qemuGuest.enable = true;
    services.spice-vdagentd.enable = true; # enable copy and paste between host and guest

    # Quickemu
    /*environment.systemPackages = with pkgs.stable; [
      quickgui
      quickemu
    ];*/
  };
}
