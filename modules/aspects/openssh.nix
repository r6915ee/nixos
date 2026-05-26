{
  den.aspects.openssh = is-server: {
    nixos =
      let
        ssh-ports = [ 5432 ];
      in
      {
        services.openssh = {
          enable = is-server;
          ports = ssh-ports;
          settings = {
            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;
            AllowUsers = [
              "decky"
              "kolya"
            ];
            UseDns = false;
            GSSAPIAuthentication = false;
            PermitRootLogin = "no";
          };
        };

        networking.firewall = {
          allowedTCPPorts = ssh-ports;
          allowedUDPPorts = ssh-ports;
        };

        # TODO: Replace once something like agenix is added.
        nix.settings.trusted-users = [ "decky" ];
      };

    provides.to-users.homeManager.services.ssh-agent.enable = true;
  };
}
