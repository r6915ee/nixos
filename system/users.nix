{ pkgs, ... }:
{
  imports = [
    <home-manager/nixos>
  ];
  nixpkgs.overlays = [
    (final: prev: {
      vinegar = prev.vinegar.overrideAttrs (
        finalAttrs: prevAttrs: {
          version = "1.9.1";
          src = final.fetchFromGitHub {
            owner = "vinegarhq";
            repo = "vinegar";
            rev = "v${finalAttrs.version}";
            hash = "sha256-QM5/nZEkGDm7Jp6X9YksiALCTSSBXbPSuny8HPRAQkw=";
          };
          vendorHash = "sha256-o1pXB8liOaOd8Nkl5jJ4wP0Q9LDACv/KH8O4iLMsUIQ=";
        }
      );
    })
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
    users.kolya =
      { ... }:
      let
        noctalia-shell = pkgs.callPackage ./custom/noctalia-shell.nix { };
      in
      {
        home.packages = [
          noctalia-shell
        ];
        programs = {
          bash.enable = false;
          fish = {
            enable = true;
            shellAliases = {
              "ls" = "eza";
              "cls" = "clear";
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
          vinegar = {
            enable = true;
            package = pkgs.vinegar;
          };
          gh-dash.enable = true;
          gitui.enable = true;
          eza.enable = true;
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
          };
          autostart.enable = true;
        };
        home.stateVersion = "25.05";
      };
  };
}
