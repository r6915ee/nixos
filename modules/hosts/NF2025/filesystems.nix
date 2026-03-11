{
  den.aspects.NF2025.nixos = {
    fileSystems."/" = {
      device = "/dev/disk/by-uuid/67e5266d-e03d-4cbf-b4fb-16eb1caaa7ec";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/0A1C-8820";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
  };
}
