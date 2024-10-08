{
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 80 443  { from = 1714; to = 1764; } ];
  networking.firewall.allowedUDPPorts = [ 53 { from = 1714; to = 1764; } ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;
}
