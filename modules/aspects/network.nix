{
  den.aspects.custom.network.nixos.networking = {
    firewall = rec {
      allowedTCPPorts = [ 22 ];
      # allowedUDPPorts = [...];
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
    networkmanager.enable = true;
    proxy = {
      # default = "http://user:password@proxy:port/";
      # noProxy = "127.0.0.1,localhost,internal.domain";
    };
  };
}
