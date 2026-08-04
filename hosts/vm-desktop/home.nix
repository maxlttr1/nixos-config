{ settings, ... }:

{
  imports = [
    ../../homeManagerModules
  ];

  custom.firefox.enable = true;
  custom.fish.enable = true;
  custom.git.enable = true;
  custom.shellAliases.enable = true;
  custom.yakuake.enable = true;
}
