{ lib, config, ... }:

{
  options = {
    powertopAutotune.enable = lib.mkEnableOption "Enable Powertop Autotune";
  };

  config = lib.mkIf config.powertopAutotune.enable {
    powerManagement.powertop.enable = true;
  };
}
