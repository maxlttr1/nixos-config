{ lib, config, ... }:

{
  options = {
    custom.powertopAutotune.enable = lib.mkEnableOption "Enable Powertop Autotune";
  };

  config = lib.mkIf config.custom.powertopAutotune.enable {
    powerManagement.powertop.enable = true;
  };
}
