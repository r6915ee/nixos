{
  den.aspects.NF2025.nixos =
    { pkgs, ... }:
    {
      services = {
        # Enable the OpenSSH daemon.
        openssh = {
          enable = true;
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

        # Enable CUPS to print documents.
        printing = {
          enable = true;
          browsed.enable = false;
          drivers = with pkgs; [
            brlaser
            brgenml1lpr
            brgenml1cupswrapper
          ];
        };

        # Enable autodiscovery of printers.
        avahi = {
          enable = true;
          nssmdns4 = true;
          openFirewall = true;
        };
      };
    };
}
