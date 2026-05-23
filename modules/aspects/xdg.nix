{
  den.aspects.xdg.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.xdg-desktop-portal
      ];

      xdg.portal = {
        enable = true;
        xdgOpenUsePortal = true;
        # extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
        # config.common.default = [ "gnome" ];
      };
    };
}
