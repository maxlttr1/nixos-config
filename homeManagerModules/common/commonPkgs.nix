{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.commonPkgs.enable = lib.mkEnableOption "common packages";

  config = lib.mkIf config.custom.commonPkgs.enable {
    home.packages = with pkgs; [

    ];
  };
}
