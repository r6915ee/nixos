{ inputs, ... }:
{
  den.aspects.programs = {
    glance.homeManager.services.glance = {
      enable = true;
      settings = {
        server.port = 5678;
        pages = [
          {
            name = "Home";
            columns = [
              {
                size = "full";
                widgets = [
                  {
                    type = "rss";
                    title = "Webcomics";
                    style = "horizontal-cards";
                    feeds = [
                      {
                        url = "https://politeandgood.com/comic/rss";
                        name = "Broccoli Soup";
                      }
                    ];
                  }
                ];
              }
            ];
          }
        ];
      };
    };
    fish.homeManager.programs = {
      fish = {
        shellAliases = {
          "cne" = "lutris lutris:rungame/codename-engine";
          "fnf" = "lutris lutris:rungame/friday-night-funkin";
        };
        shellInit = ''
          starship init fish | source
        '';
      };
      starship = {
        enable = true;
        enableFishIntegration = true;
      };
    };
    rio.homeManager = { pkgs, ... }: {
      programs.rio = {
        enable = true;
        themes.ayu = (
          fromTOML (
            builtins.readFile "${
              fetchTarball {
                url = "https://github.com/mbadolato/iTerm2-Color-Schemes/archive/aa7e97b00fb8c8bea90763563f88d84bc5a8ae8e.tar.gz";
                sha256 = "0qj8spa366rkcivkswfiphilbchjhm5zvhjv5019dkzs2r34q2la";
              }
            }/rio/Ayu.toml"
          )
        );
        settings = {
          theme = "ayu";
          window = {
            blur = true;
            opacity = 0.5;
            decorations = "Disabled";
          };
          confirm-before-quit = false;
          cursor = {
            shape = "beam";
            blinking = true;
          };
          editor.program = "hx";
          fonts = {
            size = 16;
          }
          // pkgs.lib.genAttrs [ "regular" "bold" "italic" "bold-italic" ] (name: {
            family = "0xProto Nerd Font";
            style = "default";
          });
          shell.program = "fish";
        };
      };
    };
    spotify.homeManager = { pkgs, ... }: {
      imports = [
        inputs.spicetify.homeManagerModules.spicetify
      ];

      programs.spicetify =
        let
          spicePkgs = inputs.spicetify.legacyPackages.${pkgs.stdenv.system};
        in
        {
          enable = true;
          enabledExtensions = with spicePkgs.extensions; [
            adblockify
            shuffle
            powerBar
            wikify
            history
            betterGenres
            beautifulLyrics
            spicyLyrics
            aiBandBlocker
            madeForYouShortcut
          ];
          theme = spicePkgs.themes.onepunch;
        };
    };
    gram.homeManager = { pkgs, ... }: {
      home.packages = [
        pkgs.gram
      ];
    };
  };
}
