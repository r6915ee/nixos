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
    users.kolya =
      { ... }:
      {
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
          };
          autostart.enable = true;
        };
        home.stateVersion = "25.05";
      };
  };
}
