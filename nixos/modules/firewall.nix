{
  # Open ports in the firewall.
  networking.firewall = rec {
    enable = true;
    allowedTCPPorts = [ 80 443 ];
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPorts = [ 53 ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };
}
