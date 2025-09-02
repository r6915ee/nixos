{...}:
{
  programs.virt-manager.enable = true;

  users.groups.libvirtd.members = ["kolya"];

  virtualisation.libvirtd.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;
}
