{ den, inputs, ... }:
{
  den.hosts.x86_64-linux.NF2025.users.kolya = { };

  # A system specialized for desktop usage in general. Includes general purpose
  # tools, gaming purposes, virtualisation, and more.
  den.aspects.NF2025 = {
    includes = [
      den.provides.hostname
      den.aspects.hardware
    ];
    nixos =
      { pkgs, config, ... }:
      {
        imports = [
          inputs.dms.nixosModules.greeter
        ];

        # Virtualisation
        virtualisation.podman = {
          enable = true;
          dockerCompat = true;
        };

        programs.virt-manager.enable = true;

        users.groups.libvirtd.members = [ "kolya" ];

        virtualisation.libvirtd.enable = true;

        virtualisation.spiceUSBRedirection.enable = true;

        # Fonts
        fonts.packages = with pkgs; [
          roboto
          inter
          nerd-fonts.jetbrains-mono
          nerd-fonts.fira-code
          nerd-fonts.fira-mono
          nerd-fonts.space-mono
        ];

        # List packages installed in system profile. To search, run:
        # $ nix search wget
        environment.systemPackages = with pkgs; [
          # UUtils
          (lib.hiPrio uutils-coreutils-noprefix)
          (lib.hiPrio uutils-findutils)
          (lib.hiPrio uutils-diffutils)
          # Generic packages
          # (getInputPackage "templato")
          zip
          unzip
          kdePackages.qtmultimedia
          brightnessctl
          ddcutil
          cliphist
          cabextract
          matugen
          nautilus
          wget
          cava
          wlsunset
          xdg-desktop-portal
          imagemagick
          tinty
          icu
          file
          virtualgl
          hunspell
          hunspellDicts.en_US
          plasma-panel-colorizer
          rustlings
          http-server
          polkit
          soteria
          psmisc
          nixfmt
          wl-clipboard-rs
          openssl
          rar
          speechd
          qt6Packages.qtstyleplugin-kvantum
          btop
          zenity
          efibootmgr
          OVMF
          qemu
          quickemu
          pciutils
          papirus-icon-theme
          inxi
          xwayland-satellite
          vulkan-loader
          vulkan-validation-layers
          package-version-server
          vulkan-tools
          vlc
          nss
          ffmpeg
          lldb
          nil
          nixd
          marksman
          gparted
          libsForQt5.qoauth
          libsForQt5.signond
          liboauth
          umu-launcher

          # Configure QEMU
          (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
            qemu-system-x86_64 \
              -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
              "$@"
          '')

          # Lutris
          (lutris.override {
            extraLibraries = pkgs: [
              libvorbis
              nspr
              libxdamage
              libadwaita
              gtk4
            ];
            extraPkgs = pkgs: [
              vlc
            ];
          })
        ];

        # Networking
        networking = {
          firewall = {
            allowedTCPPorts = [ 22 ];
            # allowedUDPPorts = [...];
          };

          hostName = "NF2025";

          networkmanager.enable = true;

          proxy = {
            # default = "http://user:password@proxy:port/";
            # noProxy = "127.0.0.1,localhost,internal.domain";
          };
        };

        services = {
          # Enable the OpenSSH daemon.
          openssh = {
            enable = true;
            ports = [ 22 ];
            settings = {
              PasswordAuthentication = true;
              AllowUsers = null;
              PermitRootLogin = "no";
            };
          };

          # Enable Blueman.
          blueman.enable = true;

          # Enable Flatpaks.
          flatpak.enable = true;

          # Enable FWUPD.
          fwupd.enable = true;

          # Enable the X11 windowing system.
          # You can disable this if you're only using the Wayland session.
          # xserver.enable = true;

          # Manage desktop environments.
          desktopManager = {
            # Install the base Plasma 6 desktop.
            plasma6.enable = true;
            # Install the base COSMIC desktop.
            cosmic.enable = true;
          };

          # Configure keymap in X11.
          xserver.xkb = {
            layout = "us";
            variant = "";
          };

          # Enable CUPS to print documents.
          printing.enable = true;

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

          # Enable the Accounts Daemon.
          accounts-daemon.enable = true;
        };

        # Used for configuring Pipewire.
        security.rtkit.enable = true;

        # Configure XDG Portals.
        xdg.portal = {
          enable = true;
          xdgOpenUsePortal = true;
        };

        programs = {
          # Install Steam.
          steam = {
            enable = true;
            remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
            dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
            localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
          };

          # Enable AppImages.
          appimage = {
            enable = true;
            binfmt = true;
          };

          # Enable Niri.
          niri.enable = true;

          # Enable DankGreeter.
          dank-material-shell.greeter = {
            enable = true;
            compositor.name = "niri";
          };

          # Enable ydotool.
          ydotool = {
            enable = true;
            group = "input";
          };

          # Configure Git at the system level.
          git = {
            enable = true;
            config = {
              safe.directory = "*";
            };
          };

          # Some programs need SUID wrappers, can be configured further or are
          # started in user sessions.
          # mtr.enable = true;
          # gnupg.agent = {
          #   enable = true;
          #   enableSSHSupport = true;
          # };
        };

        # Load NVIDIA driver.
        services.xserver.videoDrivers = [ "nvidia" ];

        # Hardware configuration
        hardware = {
          facter.reportPath = ./_facter.json;
          nvidia = {
            modesetting.enable = true;
            powerManagement.enable = true;
            powerManagement.finegrained = false;
            open = false;
            nvidiaSettings = false;
            package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
              version = "580.126.09";
              sha256_64bit = "sha256-TKxT5I+K3/Zh1HyHiO0kBZokjJ/YCYzq/QiKSYmG7CY=";
              sha256_aarch64 = "sha256-c5PEKxEv1vCkmOHSozEnuCG+WLdXDcn41ViaUWiNpK0=";
              openSha256 = "sha256-ychsaurbQ2KNFr/SAprKI2tlvAigoKoFU1H7+SaxSrY=";
              settingsSha256 = "sha256-4SfCWp3swUp+x+4cuIZ7SA5H7/NoizqgPJ6S9fm90fA=";
              persistencedSha256 = "sha256-J1UwS0o/fxz45gIbH9uaKxARW+x4uOU1scvAO4rHU5Y=";
            };
          };
        };
      };
  };
}
