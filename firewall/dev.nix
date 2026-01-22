{
  networking.firewall = rec {
    allowedTCPPortRanges = [ { from = 5098; to = 5099; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };
}
