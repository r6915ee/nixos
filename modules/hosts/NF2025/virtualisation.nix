{
  den.aspects.NF2025.nixos = {
    virtualisation = {
      podman = {
        enable = true;
        dockerCompat = true;
      };
      libvirtd.enable = true;
      spiceUSBRedirection.enable = true;
    };

    programs.virt-manager.enable = true;

    users.groups.libvirtd.members = [ "kolya" ];
  };
}
