{ lib, config, ... }:

{
  options = {
    gnupg.enable = lib.mkEnableOption "Enable GnuPG agent";
  };

  config = lib.mkIf config.gnupg.enable {
    programs.gnupg.agent = {
      enable = true;
    };
  };
}
