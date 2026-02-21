{ lib, config, pkgs, ... }:

{
  options = {
    custom.gnupg.enable = lib.mkEnableOption "Enable GnuPG agent";
  };

  config = lib.mkIf config.custom.gnupg.enable {
    programs.gnupg.agent = {
      enable = true;
    };

    environment.systemPackages = with pkgs.stable; [
      gnupg
    ];
  };
}
