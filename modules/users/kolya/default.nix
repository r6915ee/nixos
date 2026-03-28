{
  den,
  inputs,
  ...
}:
{
  den.aspects.kolya = {
    includes = [
      den.provides.define-user
      den.provides.primary-user
      (den.provides.user-shell "fish")
    ];
    homeManager =
      {
        pkgs,
        config,
        lib,
        ...
      }:
      let
        appman = pkgs.callPackage ./custom/appman.nix { inherit pkgs; };

        inherit (config.lib.file) mkOutOfStoreSymlink;
        inherit (lib) mergeAttrsList;

        root = "/etc/nixos/modules/users/kolya";
        toSrcFile = name: "${root}/dotfiles/${name}";

        link = name: mkOutOfStoreSymlink (toSrcFile name);

        linkFile = name: {
          ${name}.source = link name;
        };

        linkDir = name: {
          ${name} = {
            source = link name;
            recursive = true;
          };
        };

        confFiles = map linkFile [
          "niri/config.kdl"
          "appman/appman-config"
          "nixpkgs/config.nix"
        ];

        confDirs = map linkDir [ "flow" ];

        links = mergeAttrsList (confFiles ++ confDirs);

        homeDir = "/home/kolya";
      in
      {
        imports = [
          inputs.dms.homeModules.dank-material-shell
          inputs.nix-flatpak.homeManagerModules.nix-flatpak
        ];
        nixpkgs.config.allowUnfree = true;
        home = {
          username = "kolya";
          homeDirectory = homeDir;
          sessionVariables = {
            FLOW_CONFIG_DIR = toSrcFile "flow";
          };
          packages = with pkgs; [
            # Custom packages
            appman

            # Nixpkgs
            sgdboop
            nemo
            libreoffice-qt-fresh
            osu-lazer-bin
            rare
            legcord
            tlrc
            spotify
            codeberg-cli
            itch
            vscodium-fhs
            nvtopPackages.nvidia
            yt-dlp
            inputs.devenv.packages.${system}.devenv
            inkscape-with-extensions
            gimp-with-plugins
            flow-control
            kdePackages.kclock
          ];
        };
        programs = {
          bash.enable = false;
          fish = {
            shellAliases = {
              "ls" = "eza";
              "cls" = "clear";
              "cne" = "lutris lutris:rungame/codename-engine";
              "am" = "appman";
            };
            shellAbbrs = {
              "nix-shell" = "nix-shell --run fish";
              "zed" = "zeditor";
            };
            shellInit = ''
              starship init fish | source
            '';
          };
          git = {
            enable = true;
            package = pkgs.gitFull;
            settings = {
              user = {
                name = "r6915ee";
                email = "astergthefourth@gmail.com";
              };
              credential = {
                helper = "libsecret";
              };
            };
          };
          zed-editor = {
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
          jujutsu = {
            enable = true;
            settings = {
              user = {
                name = "r6915ee";
                email = "astergthefourth@gmail.com";
              };
            };
          };
          jjui = {
            enable = true;
          };
          gh = {
            enable = true;
          };
          helix = {
            enable = true;
            defaultEditor = true;
            settings = {
              theme = "ayu_dark";
            };
          };
          starship = {
            enable = true;
            enableFishIntegration = true;
          };
          ghostty = {
            enable = true;
            enableFishIntegration = true;
            settings = {
              command = "fish";
              theme = "Ayu";
              font-family = "0xProto Nerd Font";
            };
          };
          keepassxc = {
            enable = true;
            autostart = true;
          };
          nh = {
            enable = true;
            clean.enable = true;
          };
          btop = {
            enable = true;
          };
          distrobox = {
            enable = true;
            containers = {
              common-fedora = {
                additional_packages = "git";
                image = "fedora:latest";
              };
            };
            enableSystemdUnit = true;
          };
          obsidian.enable = true;
          gh-dash.enable = true;
          gitui.enable = true;
          eza.enable = true;
          ripgrep.enable = true;
          bat.enable = true;
          fastfetch.enable = true;
          zoxide.enable = true;
          dank-material-shell.enable = true;
        };
        services = {
          ssh-agent = {
            enable = true;
          };
          flatpak = {
            remotes = [
              {
                name = "flathub";
                location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
              }
              {
                name = "cosmic";
                location = "https://apt.pop-os.org/cosmic/cosmic.flatpakrepo";
              }
              {
                name = "flathub-beta";
                location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
              }
            ];
            packages = [
              "org.srb2.SRB2"
              "org.vinegarhq.Sober"
              "org.vinegarhq.Vinegar"
              "org.kartkrew.RingRacers"
              "io.github.dvlv.boxbuddyrs"
              "com.vysp3r.ProtonPlus"
              "com.core447.StreamController"
              "app.zen_browser.zen"
              "com.obsproject.Studio"
              "com.github.tchx84.Flatseal"
            ];
          };
          kdeconnect.enable = true;
        };
        xdg = {
          configFile = {
            "ghostty/config".force = true;
          }
          // links;
          autostart.enable = true;
        };
      };
  };
}
