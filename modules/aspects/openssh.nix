{
  den.aspects.openssh = is-server: {
    nixos.services.openssh = {
      enable = is-server;
      ports = [
        22
        5432
      ];
      settings = {
        PasswordAuthentication = true;
        AllowUsers = null;
        PermitRootLogin = "no";
      };
    };

    provides.to-users.homeManager.services.ssh-agent.enable = true;
  };
}
