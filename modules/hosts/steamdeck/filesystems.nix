{
  den.aspects.steamdeck.nixos = {
    fileSystems."/" = {
      device = "/dev/disk/by-uuid/1c630b91-8b49-4f67-ab62-8981421e3843";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/92C6-1907";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    swapDevices = [
      { device = "/dev/disk/by-uuid/73fd54e7-4383-49e2-af65-7b9da017d544"; }
    ];
  };
}
