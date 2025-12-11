{ ... }:
{
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  programs.virt-manager.enable = true;

  users.groups.libvirtd.members = [ "kolya" ];

  virtualisation.libvirtd.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;
}
