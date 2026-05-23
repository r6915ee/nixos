{
  den.aspects.virt.nixos =
    { pkgs, ... }:
    {
      virtualisation = {
        podman = {
          enable = true;
          dockerCompat = true;
        };
        libvirtd.enable = true;
        spiceUSBRedirection.enable = true;
      };

      environment.systemPackages = with pkgs; [
        OVMF
        qemu
        quickemu
      ];

      programs.virt-manager.enable = true;

      users.groups.libvirtd.members = [ "kolya" ];
    };
}
