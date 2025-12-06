{ pkgs, ... }:
{
  programs = {
    # Install Steam.
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

    # Install fish.
    fish.enable = true;

    # Install Git.
    git = {
      enable = true;
      package = pkgs.gitFull;
      config = {
        credential = {
          helper = "libsecret";
        };
      };
    };

    # Enable AppImages.
    appimage = {
      enable = true;
      binfmt = true;
    };

    # Enable KDE Connect.
    kdeconnect.enable = true;

    # Enable Niri.
    niri.enable = true;

    # Enable HTOP.
    htop.enable = true;

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
}
