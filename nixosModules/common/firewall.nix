{ lib, config, ... }:

{
  options = {
    firewall.enable = lib.mkEnableOption "Enable firewall";
  };

  config = lib.mkIf config.firewall.enable {
    # Open ports in the firewall.
    networking.firewall = rec {
      enable = true;
      allowedTCPPorts = [ 80 443 ];
      allowedUDPPorts = [ 53 ];
    };
  };
}
