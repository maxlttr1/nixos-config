{ config, lib, pkgs, ... }:

{
  options.yakuake.enable = lib.mkEnableOption "Enable Yakuake terminal emulator";

  config = lib.mkIf config.pkgs.enable {
    home.packages = with pkgs.stable; [
      kdePackages.yakuake
    ];

    home .file.".config/yakuakerc".text = lib.mkIf config.yakuake.enable ''
      [Dialogs]
      FirstRun=false
    '';
  };
}
