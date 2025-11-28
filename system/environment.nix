{ ... }:
{
  environment.localBinInPath = true;
  environment.sessionVariables = {
    COSMIC_DATA_CONTROL_ENABLED = 1;
    QS_ICON_THEME = "Papirus-Dark";
  };

  systemd.user.sockets.gcr-ssh-agent.enable = true;
}
