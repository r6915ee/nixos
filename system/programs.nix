{pkgs, ...}:
{
  # Install Steam.
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  programs.ssh.startAgent = true;

  # Install fish.
  programs.fish.enable = true;

  # Install Git.
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    config = {
      credential = {
        helper = "libsecret";
      };
    };
  };

  # Enable KDE Connect.
  programs.kdeconnect.enable = true;

  # Enable Miracle.
  programs.wayland.miracle-wm.enable = true;

  # Enable HTOP.
  programs.htop.enable = true;

  # Enable nh.
  programs.nh = {
    enable = true;
    clean.enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}
