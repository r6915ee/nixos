{ pkgs, ... }:
{
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = null;
      PermitRootLogin = "no";
    };
  };

  # Enable various passkey utilities from GNOME.
  services.gnome = {
    gnome-keyring.enable = true;
    gcr-ssh-agent.enable = false;
  };

  # Enable Flatpaks.
  services.flatpak.enable = true;

  # Configure XDG Portals.
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };

  # Enable FWUPD.
  services.fwupd.enable = true;
  
  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  # services.xserver.enable = true;

  services.displayManager = {
    sessionPackages = [
      (pkgs.miracle-wm.overrideAttrs (old: {
        postInstall =
          let
            gbm-kms = ''
              [Desktop Entry]
              Name=Miracle (GBM-KMS)
              Comment=Miracle, using the GBM-KMS backend
              Exec=miracle-wm-session --platform-display-libs=mir:gbm-kms
              Type=Application
            '';
            atomic-kms = ''
              [Desktop Entry]
              Name=Miracle (Atomic-KMS)
              Comment=Miracle, using the Atomic-KMS backend
              Exec=miracle-wm-session --platform-display-libs=mir:atomic-kms
              Type=Application
            '';
          in
          ''
            echo "${gbm-kms}" > $out/share/wayland-sessions/miracle-gbm-kms.desktop
            echo "${atomic-kms}" > $out/share/wayland-sessions/miracle-atomic-kms.desktop
          '';
        passthru.providedSessions = [ "miracle-gbm-kms" ];
      }))
    ];
    gdm.enable = true;
  };

  # Manage desktop environments.
  services.desktopManager = {
    # Install the base Plasma 6 desktop.
    plasma6.enable = true;
    # Install the base COSMIC desktop.
    cosmic.enable = true;
  };
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
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
  services.accounts-daemon.enable = true;
}
