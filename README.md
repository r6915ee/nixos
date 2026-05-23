# BalladOS

This is a NixOS configuration for my own setup.

The core of the configuration is based on a single Nix flake but, more
importantly, the [`den`](https://den.oeiuwq.com/) library. The library allows
splitting and sharing configuration, which is used often here to support
consistency between machines.

The flake is based on the `nixos-unstable` branch of Nixpkgs.

### Programs

Some notable programs include:

- Fish
- Ghostty
- Flatpak
- uutils
- Lutris
- Steam
- Zed
- Niri
- DankLinux (`dms`, `dms-greeter`)

## License

The repository is licensed under the [WTFPL license](LICENSE). In short, you
are able to do anything with the code provided in this repository.
