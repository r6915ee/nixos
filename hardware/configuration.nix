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
      package = config.boot.kernelPackages.nvidiaPackages.latest;
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
