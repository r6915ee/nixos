{config, ...}:
{
  # Load NVIDIA driver.
  services.xserver.videoDrivers = ["nvidia"];

  # Handle graphics, such as with NVIDIA.
  hardware = {
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
  };
}
