{ inputs, den, ... }:
{
  den.aspects.desktop = cosmic-greeter: {
    includes = [
      (den.aspects.flatpak [ ])
    ];

    provides = {
      niri = {
        nixos =
          { pkgs, ... }:
          {
            imports = [
              inputs.niri.nixosModules.niri
            ];
            nixpkgs.overlays = [ inputs.niri.overlays.niri ];

            environment.systemPackages = [ pkgs.xwayland-satellite ];

            programs = {
              # Enable Niri.
              niri = {
                enable = true;
                package = pkgs.niri-unstable;
              };
            };

            services.displayManager.cosmic-greeter.enable = cosmic-greeter;
          };
        provides.to-users.homeManager = {
          imports = [
            inputs.dms.homeModules.dank-material-shell
          ];

          programs.dank-material-shell.enable = true;
        };
      };

      ydotool.nixos.programs.ydotool = {
        enable = true;
        group = "input";
      };
    };

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          vulkan-loader
          vulkan-validation-layers
          vulkan-tools
        ];

        hardware.graphics = {
          enable = true;
          enable32Bit = true;
        };

        programs = {
          # Enable nix-ld.
          nix-ld.enable = true;

          # Enable AppImages.
          appimage = {
            enable = true;
            binfmt = true;
          };

          # Enable nh.
          nh = {
            enable = true;
            clean.enable = true;
          };

          # Some programs need SUID wrappers, can be configured further or are
          # started in user sessions.
          # mtr.enable = true;
          # gnupg.agent = {
          #   enable = true;
          #   enableSSHSupport = true;
          # };
        };
        services = {
          system76-scheduler.enable = true;
          blueman.enable = true;
          xserver.enable = false;

          xserver.xkb = {
            layout = "us";
            variant = "";
          };

          # Enable sound with pipewire.
          pulseaudio.enable = false;
          pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            # If you want to use JACK applications, uncomment this
            #jack.enable = true;

            # use the example session manager (no others are packaged yet so this is enabled by default,
            # no need to redefine it in your config for now)
            #media-session.enable = true;
          };
        };
        security.rtkit.enable = true;
      };
  };
}
