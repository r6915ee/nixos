# r6915ee's NixOS Configuration

This is a NixOS configuration for my own setup.

The configuration is designed to be modular. Because of this, it's split into
separate files, each with their own unique task. It performs this using the
[`den`](https://den.oeiuwq.com/) library.

## Usage

The configuration directly expects the NixOS unstable repository to be used.

Perhaps the two most important inputs for the flake are [Home
Manager](https://github.com/nix-community/home-manager/)) and, of course,
`den`. These are provided as Flake inputs. No other inputs exist for the flake,
with the exceptions of programs that are provided as inputs, e.g. `dms`.

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
- DankLinux (`dms`, `dms-greeter`)

## License

Although the repository was previously licensed under the MIT license, this is
no longer the case, since it wouldn't make sense for something like a set of
configuration files having a license. You are free to use any of the
configuration as you please.
