{
  # Open ports in the firewall.
  networking.firewall = rec {
    enable = true;
    allowedTCPPorts = [ 80 443 ];
    allowedUDPPorts = [ 53 ];
  };
}
