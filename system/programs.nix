{ ... }:
{
  programs = {
    # Install Steam.
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

    # Install fish. Necessary for setting user shell.
    fish.enable = true;

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
}
