{ lib, config, settings, ... }:

{
  options = {
    virtualbox.enable = lib.mkEnableOption "Enable VirtualBox";
  };

  config = lib.mkIf config.virtualbox.enable {
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ "${settings.username}" ];
  };
}
