{ pkgs, ... }:
{
  imports = [
    <home-manager/nixos>
  ];
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kolya = {
    isNormalUser = true;
    description = "Kolya";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
    packages = [ ];
  };
  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    users.kolya =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      let
        noctalia-shell = pkgs.callPackage ./custom/noctalia-shell.nix { };
        appman = pkgs.callPackage ./custom/appman.nix { };
        yazi-plugins = {
          base = fetchTarball "https://github.com/yazi-rs/plugins/archive/refs/heads/main.tar.gz";
          starship = fetchTarball "https://github.com/Rolv-Apneseth/starship.yazi/archive/refs/heads/main.tar.gz";
        };

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
        home.packages = with pkgs; [
          # Custom
          noctalia-shell
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
          nvtopPackages.nvidia
        ];
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
          yazi = {
            enable = true;
            settings = {
              mgr = {
                show_hidden = true;
                prepend_fetchers = [
                  {
                    id = "git";
                    name = "*";
                    run = "git";
                  }
                  {
                    id = "git";
                    name = "*/";
                    run = "git";
                  }
                ];
              };
            };
            plugins = {
              chmod = "${yazi-plugins.base}/chmod.yazi";
              git = "${yazi-plugins.base}/git.yazi";
              diff = "${yazi-plugins.base}/diff.yazi";
              mount = "${yazi-plugins.base}/mount.yazi";
              smart-enter = "${yazi-plugins.base}/smart-enter.yazi";
              starship = "${yazi-plugins.starship}";
            };
            initLua = ''
              -- require("git"):setup()
              require("starship"):setup()
            '';
            keymap = {
              mgr = {
                keymap = [
                  # Navigation
                  {
                    on = "<Enter>";
                    run = "plugin smart-enter";
                    desc = "Enter the child directory, or open the file";
                  }
                  {
                    on = "<Esc>";
                    run = "escape";
                    desc = "Exit out of various modes";
                  }
                  {
                    on = "<Backspace>";
                    run = "leave";
                    desc = "Go to the parent directory";
                  }
                  {
                    on = "<Up>";
                    run = "arrow prev";
                    desc = "Go to the previous sorted file";
                  }
                  {
                    on = "<Down>";
                    run = "arrow next";
                    desc = "Go to the next sorted file";
                  }
                  # Goto
                  {
                    on = [
                      "g"
                      "<Space>"
                    ];
                    run = "cd --interactive";
                    desc = "CD to a specified directory";
                  }
                  {
                    on = [
                      "g"
                      "r"
                    ];
                    run = "shell -- ya emit cd \"$(git rev-parse --show-toplevel)\"";
                    desc = "Move to the current Git repository's root";
                  }
                  {
                    on = "<Space>";
                    run = "toggle";
                    desc = "Select a file";
                  }
                  {
                    on = "<C-a>";
                    run = "toggle_all";
                    desc = "Select all files";
                  }
                  # Generic file commands
                  {
                    on = [
                      "c"
                      "m"
                    ];
                    run = "plugin chmod";
                    desc = "Chmod on selected files";
                  }
                  {
                    on = "<C-d>";
                    run = "plugin diff";
                    desc = "Diff the selected file with the hovered file";
                  }
                  {
                    on = "q";
                    run = "quit";
                    desc = "Quit Yazi";
                  }
                  {
                    on = "<S-q>";
                    run = "suspend";
                    desc = "Suspend Yazi";
                  }
                  {
                    on = "a";
                    run = "create";
                    desc = "Create a file (ends with / for directories)";
                  }
                  {
                    on = "l";
                    run = "link";
                    desc = "Create a symlink to the yanked files";
                  }
                  {
                    on = "L";
                    run = "hardlink";
                    desc = "Create a hard link to the yanked files";
                  }
                  {
                    on = "y";
                    run = "yank";
                    desc = "Yank the selected files";
                  }
                  {
                    on = "Y";
                    run = "unyank";
                    desc = "Cancel the yank status of files";
                  }
                  {
                    on = "d";
                    run = "yank --cut";
                    desc = "Cut the selected files";
                  }
                  {
                    on = "x";
                    run = "remove --force";
                    desc = "Trash selected files";
                  }
                  {
                    on = "<S-x>";
                    run = "remove --force --permanently";
                    desc = "Permanently delete selected files";
                  }
                  {
                    on = "p";
                    run = "paste";
                    desc = "Paste the last yanked files";
                  }
                  {
                    on = "m";
                    run = "rename";
                    desc = "Rename all selected files";
                  }
                  {
                    on = ".";
                    run = "hidden toggle";
                    desc = "Toggle showing hidden files";
                  }
                  # Finding
                  {
                    on = "/";
                    run = "find --smart";
                    desc = "Find next file";
                  }
                  {
                    on = "?";
                    run = "find --previous --smart";
                    desc = "Find previous file";
                  }
                  {
                    on = "n";
                    run = "find_arrow";
                    desc = "Next found";
                  }
                  {
                    on = "N";
                    run = "find_arrow --previous";
                    desc = "Previous found";
                  }
                  # Command-line mode
                  {
                    on = ";";
                    run = "shell --interactive";
                    desc = "Run a shell command";
                  }
                  {
                    on = ":";
                    run = "shell --block --interactive";
                    desc = "Run a shell command (block until command finishes)";
                  }
                  # Tabs
                  {
                    on = [
                      "t"
                      "a"
                    ];
                    run = "tab_create";
                    desc = "Create a tab";
                  }
                  {
                    on = [
                      "t"
                      "d"
                    ];
                    run = "close";
                    desc = "Close the current tab";
                  }
                  {
                    on = [
                      "t"
                      "<Left>"
                    ];
                    run = "tab_switch --relative -1";
                    desc = "Switch to the previous tab";
                  }
                  {
                    on = [
                      "t"
                      "<Right>"
                    ];
                    run = "tab_switch --relative 1";
                    desc = "Switch to the next tab";
                  }
                  # Misc.
                  {
                    on = "v";
                    run = "visual_mode";
                    desc = "Switch to visual mode";
                  }
                  {
                    on = "V";
                    run = "visual_mode --unset";
                    desc = "Switch to unset visual mode";
                  }
                ];
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
            "quickshell/noctalia-shell".source = "${noctalia-shell.out}/bin/";
          }
          // links;
          autostart.enable = true;
        };
        home = {
          stateVersion = "25.05";
        };
      };
  };
}
