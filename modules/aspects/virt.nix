{
  den.aspects.virt = {
    nixos = {
      virtualisation = {
        podman = {
          enable = true;
          dockerCompat = true;
        };
        lxc.enable = true;
        incus.enable = true;
        incus.ui.enable = true;
      };
    };
    provides.to-users.user.extraGroups = [ "incus-admin" ];
  };
}
