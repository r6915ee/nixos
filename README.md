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

The configuration does not use any special programs besides nixGL, as stated
above. This includes Flakes, Home Manager, and more. All of it is pure NixOS.

### Programs

Some notable programs include:

* KDE Plasma
* COSMIC
* Miracle (incomplete support due to NVIDIA issues)
* Flatpak
* uutils (replacement for GNU utils, e.g. coreutils)
* Legcord (Discord client)
* Lutris
* Steam
* Zed

## License

Although the repository was previously licensed under the MIT license, this is
no longer the case, since it wouldn't make sense for something like a set of
configuration files having a license. You are free to use any of the
configuration as you please.
