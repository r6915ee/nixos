{
  config,
  pkgs,
  lib,
  ...
}:
let
  appman = pkgs.callPackage ./custom/appman.nix { };

  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (lib) mergeAttrsList;

  toSrcFile = name: "/home/kolya/Documents/nixos/dotfiles/${name}";

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

  confDirs = map linkDir [ ];

  links = mergeAttrsList (confFiles ++ confDirs);
in
{
  home = {
    username = "kolya";
    homeDirectory = "/home/kolya";
    stateVersion = "25.05";
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
    ];
  };

  programs = {
    bash.enable = false;
    fish = {
      enable = true;
      shellAliases = {
        "ls" = "eza";
        "cls" = "clear";
        "cne" = "lutris lutris:rungame/codename-engine";
        "am" = "appman";
      };
      shellAbbrs = {
        "nix-shell" = "nix-shell --run fish";
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
        buffer_font_family = "SpaceMono Nerd Font";
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
        font-family = "SpaceMono Nerd Font";
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
  };

  services = {
    ssh-agent = {
      enable = true;
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
}
