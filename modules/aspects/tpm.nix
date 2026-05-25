{
  den.aspects.tpm = enable: {
    nixos = {
      systemd.tpm2.enable = enable;
      security.tpm2.enable = enable;
    };
  };
}
