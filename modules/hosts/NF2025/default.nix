{ den, lib, ... }:
{
  den.hosts.x86_64-linux.NF2025 = {
    hostName = "NF2025";
    users.kolya = { };
  };

  # A system specialized for desktop usage in general. Includes general purpose
  # tools, gaming purposes, virtualisation, and more. The following code
  # contains mostly immutable code or code too short to allow delegating files.
  den.aspects.NF2025 = {
    includes = [
      den.provides.hostname

      den.aspects.hardware
      (den.aspects.network false)
      den.aspects.fonts
      den.aspects.xdg
      den.aspects.virt

      den.aspects.boot

      den.aspects.gaming
      den.aspects.desktop

      den.aspects.git
      (den.aspects.tpm false)
      (den.aspects.openssh true)
    ]
    ++ lib.attrValues den.aspects.desktop.provides;

    nixos =
      { config, ... }:
      {
        imports = [
          ../../../cachix.nix
        ];

        system.stateVersion = "25.05";

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
            # package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
            # version = "580.159.03";
            # sha256_64bit = "sha256-TKxT5I+K3/Zh1HyHiO0kBZokjJ/YCYzq/QiKSYmG7CY=";
            # sha256_aarch64 = "sha256-c5PEKxEv1vCkmOHSozEnuCG+WLdXDcn41ViaUWiNpK0=";
            # openSha256 = "sha256-ychsaurbQ2KNFr/SAprKI2tlvAigoKoFU1H7+SaxSrY=";
            # settingsSha256 = "sha256-4SfCWp3swUp+x+4cuIZ7SA5H7/NoizqgPJ6S9fm90fA=";
            # persistencedSha256 = "sha256-J1UwS0o/fxz45gIbH9uaKxARW+x4uOU1scvAO4rHU5Y=";
            # };
            package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
          };
          # printers = {
          #   ensureDefaultPrinter = "Brother_MFC-7840W";
          #   ensurePrinters = [
          #     {
          #       name = "Brother_MFC-7840W";
          #       deviceUri = "socket://192.168.0.204:9100";
          #       model = "everywhere";
          #     }
          #   ];
          # };
        };
      };
  };
}
