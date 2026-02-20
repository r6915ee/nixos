{ config, ... }:
{
  # Load NVIDIA driver.
  services.xserver.videoDrivers = [ "nvidia" ];

  # Handle hardware.
  hardware = {
    # Used for OSS emulation, as there is no stable feature to set
    # NixOS options in Nix shells at the moment.
    alsa.enableOSSEmulation = true;

    graphics.enable = true;
    # Primarily used for Wine-based programs,
    # such as Lutris.
    graphics.enable32Bit = true;

    # NVIDIA driver configuration
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

    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
        };
        Policy = {
          AutoEnable = true;
        };
      };
    };
  };
}
