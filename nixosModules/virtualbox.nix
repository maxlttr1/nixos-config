{ lib, config, settings, ... }:

{
  options = {
    custom.virtualbox.enable = lib.mkEnableOption "Enable VirtualBox";
  };

  config = lib.mkIf config.custom.virtualbox.enable {
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ "${settings.username}" ];
  };
}
