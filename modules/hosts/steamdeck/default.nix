{ den, lib, ... }:
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

      den.aspects.hardware
      den.aspects.network
      den.aspects.fonts
      den.aspects.xdg

      den.aspects.boot

      den.aspects.gaming
      den.aspects.desktop
    ]
    ++ lib.attrValues den.aspects.desktop.provides;

    nixos = {
      imports = [
        ../../../cachix.nix
      ];

      system.stateVersion = "25.11";
    };
  };
}
