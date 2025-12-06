# r6915ee's NixOS Configuration

This is a NixOS configuration for my own setup.

The configuration is designed to be modular. Because of this, it's split into
separate files, each with their own unique task.

## Usage

If you want to directly use this configuration, then make sure to change
both files under [`hardware`](./hardware/). Both of the files under there are
hardware-specific, supporting NVIDIA. `configuration.nix` under that directory
is for NVIDIA and ALSA, and `scan.nix` is what was generated from the hardware
scan when installing using the graphical NixOS installer.

You may also change [`system/users.nix`](./system/users.nix), as that details
user information declaratively.

The configuration directly expects the unstable channel to be used. In
addition, [nixGL](https://github.com/nix-community/nixGL) is expected to be
installed through its channel form as well.

The one additional piece of Nix software at play is [Home
Manager](https://github.com/nix-community/home-manager); specifically, Home
Manager is expected to be used as a NixOS module. Install it as a Nix channel
and you should be all good.

### Programs

Some notable programs include:

- Fish
- Starship
- Ghostty
- KDE Plasma
- COSMIC
- Flatpak
- uutils (replacement for GNU utils, e.g. coreutils)
- Legcord (Discord client)
- Lutris
- Steam
- Zed
- Niri

## License

Although the repository was previously licensed under the MIT license, this is
no longer the case, since it wouldn't make sense for something like a set of
configuration files having a license. You are free to use any of the
configuration as you please.
