{ settings, ... }:

{
  imports = [
    ../../homeManagerModules
  ];

  custom.firefox.enable = true;
  custom.fish.enable = true;
  custom.git.enable = true;
}
