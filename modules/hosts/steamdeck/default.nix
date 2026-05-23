{ den, ... }:
{
  den.hosts.x86_64-linux.steamdeck = {
    hostName = "steamdeck";
    users.decky = { };
  };

  # A Steam Deck configuration, specifically for an LCD model. The SSD has been
  # manually replaced with a larger, third-party one. Unlike other setups, this
  # configuration is rather manual in order to provide full control.
  den.aspects.steamdeck = {
    includes = [
      den.batteries.hostname

      den.aspects.custom.hardware
      den.aspects.custom.network
      den.aspects.custom.fonts
      den.aspects.custom.xdg

      den.aspects.custom.boot

      den.aspects.custom.desktop
    ];

    nixos = { };
  };
}
