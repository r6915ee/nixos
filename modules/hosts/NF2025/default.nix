{ den, ... }:
{
  den.hosts.x86_64-linux.NF2025.users.kolya = { };

  # A system specialized for desktop usage in general. Includes general purpose
  # tools, gaming purposes, virtualisation, and more. The following code
  # contains mostly immutable code or code too short to allow delegating files.
  den.aspects.NF2025 = {
    includes = [
      den.provides.hostname
      den.aspects.hardware
    ];
    nixos =
      { pkgs, config, ... }:
      {
        # Fonts
        fonts.packages = with pkgs; [
          roboto
          inter
          nerd-fonts.jetbrains-mono
          nerd-fonts.fira-code
          nerd-fonts.fira-mono
          nerd-fonts.space-mono
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

        # Used for configuring Pipewire.
        security.rtkit.enable = true;

        # Configure XDG Portals.
        xdg.portal = {
          enable = true;
          xdgOpenUsePortal = true;
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
