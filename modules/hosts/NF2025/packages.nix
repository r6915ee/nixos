{ inputs, ... }:
{
  den.aspects.NF2025.nixos =
    {
      pkgs,
      ...
    }:
    {
      # List packages installed in system profile. To search, run:
      # $ nix search wget
      environment.systemPackages = with pkgs; [
        # UUtils
        (lib.hiPrio uutils-coreutils-noprefix)
        (lib.hiPrio uutils-findutils)
        (lib.hiPrio uutils-diffutils)
        # Generic packages
        (inputs.templato.packages.x86_64-linux.default)
        zip
        unzip
        fragments
        matugen
        nautilus
        wget
        cava
        rnote
        imagemagick
        icu
        file
        virtualgl
        hunspell
        hunspellDicts.en_US
        http-server
        polkit
        psmisc
        nixfmt
        wl-clipboard-rs
        btop
        alejandra
        zenity
        efibootmgr
        pciutils
        papirus-icon-theme
        package-version-server
        vlc
        nss
        ffmpeg
        nil
        nixd
        marksman
        gparted
        liboauth

        # Configure QEMU
        (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
          qemu-system-x86_64 \
            -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
            "$@"
        '')

        # Lutris
        (lutris.override {
          buildFHSEnv =
            args:
            pkgs.buildFHSEnv (
              args
              // {
                multiPkgs =
                  envPkgs:
                  let
                    originalPkgs = args.multiPkgs envPkgs;

                    customLdap = envPkgs.openldap.overrideAttrs (_: {
                      doCheck = false;
                    });
                  in
                  # Replace broken openldap with the custom one
                  builtins.filter (p: (p.pname or "") != "openldap") originalPkgs ++ [ customLdap ];
              }
            );
          extraLibraries = pkgs: [
            libvorbis
            nspr
            libxdamage
            libadwaita
            gtk4
          ];
          extraPkgs = pkgs: [
            vlc
          ];
        })
      ];
    };
}
