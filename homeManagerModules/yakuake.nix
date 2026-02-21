{ config, lib, pkgs, ... }:

{
  options.custom.yakuake.enable = lib.mkEnableOption "Enable Yakuake terminal emulator";

  config = lib.mkIf config.custom.yakuake.enable {
    home.packages = with pkgs.stable; [
      kdePackages.yakuake
    ];

    home .file.".config/yakuakerc".text = lib.mkIf config.custom.yakuake.enable ''
      [Dialogs]
      FirstRun=false
    '';
  };
}
