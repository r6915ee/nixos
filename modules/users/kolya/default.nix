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
      den.aspects.programs.zeditor
      den.aspects.cursor
      (den.provides.user-shell "fish")
    ];
    user = {
      extraGroups = [ "cups" ];
    };
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
          stateVersion = "25.05";
          sessionVariables = {
            FLOW_CONFIG_DIR = toSrcFile "flow";
            SOBER_USE_NEW_TEXT_RENDERER = "1";
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
            discordo
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
          mangohud = {
            enable = true;
            enableSessionWide = true;
          };
          fish = {
            shellAliases = {
              "ls" = "eza";
              "cls" = "clear";
              "cne" = "lutris lutris:rungame/codename-engine";
              "fnf" = "lutris lutris:rungame/friday-night-funkin";
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
          retroarch = {
            enable = true;
            cores = {
              snes9x = {
                enable = true;
                package = pkgs.libretro.snes9x;
              };
              mgba = {
                enable = true;
                package = pkgs.libretro.mgba;
              };
              # Albeit melonds is preferred, desmume is kept for legacy purposes.
              desmume = {
                enable = true;
                package = pkgs.libretro.desmume;
              };
              melonds = {
                enable = true;
                package = (
                  pkgs.libretro.melonds.overrideDerivation (old: {
                    NIX_CFLAGS_COMPILE = "-Wl,-z,noexecstack";
                  })
                );
              };
            };
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
              "info.beyondallreason.bar"
              "com.discordapp.Discord"
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
