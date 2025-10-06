{ ... }:
{
  security.sudo.enable = false;
  security.doas = {
    enable = true;
    extraRules = [{
      users = ["kolya"];
      keepEnv = true;
      persist = true;
    }];
  };
}
