{
  den.aspects.NF2025.nixos =
    { pkgs, ... }:
    {
      services = {
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
