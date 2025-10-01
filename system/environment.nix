{...}:
{
  environment.localBinInPath = true;
  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;

  systemd.user.sockets.gcr-ssh-agent.enable = true;
}
