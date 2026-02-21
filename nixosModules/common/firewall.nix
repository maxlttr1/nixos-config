{ lib, config, ... }:

{
  options = {
    custom.firewall.enable = lib.mkEnableOption "Enable firewall";
  };

  config = lib.mkIf config.custom.firewall.enable {
    # Open ports in the firewall.
    networking.firewall = rec {
      enable = true;
      allowedTCPPorts = [ 80 443 ];
      allowedUDPPorts = [ 53 ];
    };
  };
}
