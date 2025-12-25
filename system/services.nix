{ pkgs, ... }:
{
  # List services that you want to enable:

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

    # Enable cosmic-greeter as the display manager.
    displayManager.cosmic-greeter.enable = true;

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

    # Configure udev.
    udev = {
      packages = [
        (pkgs.callPackage ./custom/opendeck.nix { })
      ];
    };
  };

  # Used for configuring Pipewire.
  security.rtkit.enable = true;

  # Configure XDG Portals.
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };
}
