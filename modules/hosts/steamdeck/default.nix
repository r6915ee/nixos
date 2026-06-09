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
    includes =
      let
        desktop = den.aspects.desktop false;
      in
      [
        den.batteries.hostname

        den.aspects.hardware
        (den.aspects.network true)
        den.aspects.fonts
        den.aspects.xdg

        den.aspects.boot

        den.aspects.gaming
        desktop

        den.aspects.git
        (den.aspects.tpm false)
        (den.aspects.openssh true)
      ]
      ++ lib.attrValues desktop.provides;

    nixos =
      { pkgs, ... }:
      {
        imports = [
          ../../../cachix.nix
        ];

        system.stateVersion = "25.11";

        services.greetd.settings.initial_session = {
          command = "steam-gamescope";
          user = "decky";
        };

        environment.systemPackages = with pkgs; [
          wvkbd
          brightnessctl
        ];

        programs.steam = {
          extest.enable = true;
          gamescopeSession = {
            enable = true;
          };
        };

        hardware.facter.reportPath = ./_facter.json;
      };
  };
}
