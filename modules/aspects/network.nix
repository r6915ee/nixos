{
  den.aspects.network = support-wireless: {
    nixos =
      { lib, ... }:
      {
        networking = {
          nftables.enable = true;
          firewall = rec {
            allowedTCPPorts = [
              22
              5432
              5678
            ];
            allowedUDPPorts = [
              5678
            ];
            allowedTCPPortRanges = [
              {
                from = 1714;
                to = 1764;
              }
            ];
            allowedUDPPortRanges = allowedTCPPortRanges;
          };
          networkmanager.enable = true;
          wireless.enable = lib.mkDefault support-wireless;
          proxy = {
            # default = "http://user:password@proxy:port/";
            # noProxy = "127.0.0.1,localhost,internal.domain";
          };
        };
      };
  };
}
