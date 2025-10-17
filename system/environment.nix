{ pkgs, ... }:
{
  environment.localBinInPath = true;
  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    xwaylandvideobridge
  ];

  systemd.user.sockets.gcr-ssh-agent.enable = true;
}
