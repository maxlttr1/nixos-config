{ lib, config, ... }:

{
  options = {
    virtualbox.enable = lib.mkEnableOption "Enable VirtualBox";
  };

  config = lib.mkIf config.virtualbox.enable {
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ "${config.users.mainUsername}" ];
  };
}
