{ settings, ... }:

{
   virtualisation.virtualbox.host.enable = true;
   users.extraGroups.vboxusers.members = [ "${settings.username}" ];
}