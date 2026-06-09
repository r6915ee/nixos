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
      den.aspects.cursor
      (den.provides.user-shell "fish")
      den.aspects.systematic

      den.aspects.programs.glance
      den.aspects.programs.zeditor
      den.aspects.programs.fish
      den.aspects.programs.ghostty

      (den.aspects.dots
        [
          {
            path = "niri/config.kdl";
            symlinked = true;
          }
        ]
        [ ]
      )

      (den.aspects.flatpak [
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
      ])
    ];
    user = {
      extraGroups = [ "cups" ];
    };
    homeManager =
      {
        pkgs,
        ...
      }:
      let
        homeDir = "/home/kolya";
      in
      {
        nixpkgs.config.allowUnfree = true;
        home = {
          username = "kolya";
          homeDirectory = homeDir;
          stateVersion = "25.05";
          sessionVariables = {
            SOBER_USE_NEW_TEXT_RENDERER = "1";
          };
          packages = with pkgs; [
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
              "cne" = "lutris lutris:rungame/codename-engine";
              "fnf" = "lutris lutris:rungame/friday-night-funkin";
            };
            shellInit = ''
              starship init fish | source
            '';
          };
          helix = {
            enable = true;
            defaultEditor = true;
            settings = {
              theme = "ayu_dark";
            };
          };
          keepassxc = {
            enable = true;
            autostart = true;
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
          gh.enable = true;
          obsidian.enable = true;
          gh-dash.enable = true;
          gitui.enable = true;
        };
        services = {
          ssh-agent.enable = true;
          kdeconnect.enable = true;
        };
        xdg.autostart.enable = true;
      };
  };
}
