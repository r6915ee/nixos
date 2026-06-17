{ den, ... }:
{
  den.aspects.gaming = {
    nixos.programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
        localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      };
      gamescope.enable = true;
    };

    provides.to-users = {
      includes = [
        (den.aspects.flatpak [
          "org.srb2.SRB2"
          "org.vinegarhq.Sober"
          "org.vinegarhq.Vinegar"
          "org.kartkrew.RingRacers"
          "com.vysp3r.ProtonPlus"
          "com.obsproject.Studio"
          "info.beyondallreason.bar"
        ])
      ];

      homeManager =
        { pkgs, osConfig, ... }:
        {
          home.packages = with pkgs; [
            itch
            # This is primarily useful for itch, where some games get
            # distributed using love files.
            love
            sgdboop
            osu-lazer-bin
            rare
            discordo
          ];
          programs.lutris = {
            enable = true;
            steamPackage = osConfig.programs.steam.package;
            package = (
              pkgs.lutris.override {
                buildFHSEnv =
                  args:
                  pkgs.buildFHSEnv (
                    args
                    // {
                      multiPkgs =
                        envPkgs:
                        let
                          originalPkgs = args.multiPkgs envPkgs;

                          customLdap = envPkgs.openldap.overrideAttrs (_: {
                            doCheck = false;
                          });
                        in
                        # Replace broken openldap with the custom one
                        builtins.filter (p: (p.pname or "") != "openldap") originalPkgs ++ [ customLdap ];
                    }
                  );
                extraLibraries =
                  with pkgs;
                  pkgs: [
                    libvorbis
                    nspr
                    libxdamage
                    libadwaita
                    gtk4
                    libvlc
                    libvlcpp
                  ];
                extraPkgs =
                  with pkgs;
                  pkgs: [
                    vlc
                  ];
              }
            );
          };
        };
    };
  };
}
