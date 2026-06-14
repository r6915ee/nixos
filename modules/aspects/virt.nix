{
  den.aspects.virt = virt-viewer: {
    nixos = { pkgs, ... }: {
      virtualisation = {
        podman = {
          enable = true;
          dockerCompat = true;
        };
        lxc.enable = true;
        incus.enable = true;
        incus.ui.enable = true;
      };

      environment.systemPackages = if virt-viewer then [ pkgs.virt-viewer ] else [ ];
    };
    provides.to-users.user.extraGroups = [ "incus-admin" ];
  };
}
