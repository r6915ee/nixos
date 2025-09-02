{...}:

{
  networking = {
    firewall = {
      # allowedTCPPorts = [...];
      # allowedUDPPorts = [...];
    };

    hostName = "NF2025";

    networkmanager.enable = true;

    proxy = {
      # default = "http://user:password@proxy:port/";
      # noProxy = "127.0.0.1,localhost,internal.domain";
    };
  };
}
