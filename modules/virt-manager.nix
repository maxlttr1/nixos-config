{ settings, ... }:

{
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  users.groups.libvirtd.members = ["${settings.username}"];
  users.users.${settings.username}.extraGroups = ["libvirtd"];

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;  # enable copy and paste between host and guest
}