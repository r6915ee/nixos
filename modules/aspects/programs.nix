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
    ghostty.homeManager.programs.ghostty = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        command = "fish";
        theme = "Ayu";
        font-family = "0xProto Nerd Font";
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
    zeditor.homeManager.programs.zed-editor = {
      enable = true;
      extensions = [
        "nix"
        "toml"
        "rust"
        "lua"
        "git-firefly"
        "xml"
        "ruby"
        "ini"
        "gdscript"
        "just"
        "base16"
        "asciidoc"
        "haxe"
        "typst"
      ];
      userSettings = {
        theme = {
          mode = "system";
          dark = "Ayu Dark";
          light = "Ayu Light";
        };
        vim_mode = true;
        minimap = {
          show = "auto";
          thumb = "hover";
        };
        buffer_font_family = "0xProto Nerd Font";
        base_keymap = "JetBrains";
        telemetry.metrics = false;
        hard_tabs = false;
        disable_ai = true;
        terminal.shell.program = "fish";
        lsp = {
          tinymist = {
            settings = {
              formatterMode = "typstyle";
              formatterPrintWidth = 80;
            };
          };
          package-version-server = {
            enable_lsp_tasks = false;
          };
          luau-lsp = {
            settings = {
              luau-lsp = {
                plugin.enabled = true;
                roblox.enabled = true;
              };
            };
          };
        };
        languages = {
          "Markdown".format_on_save = "on";
          "Lua" = {
            tab_size = 3;
            format_on_save = "on";
          };
          "Luau" = {
            tab_size = 3;
            format_on_save = "on";
          };
          "Typst" = {
            tab_size = 2;
            format_on_save = "on";
            formatter = {
              external = {
                command = "typstyle";
                arguments = [
                  "-l"
                  "80"
                  "-t"
                  "2"
                ];
              };
            };
          };
        };
      };
    };
  };
}
