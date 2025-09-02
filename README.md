# r6915ee's NixOS Configuration

This is a NixOS configuration for my own setup.

The configuration is designed to be modular. Because of this, it's split into
separate files, each with their own unique task.

## Usage

If you want to directly use this configuration, then make sure to change
both files under [`hardware`](./hardware/). Both of the files under there are
hardware-specific. `configuration.nix` under that directory is for NVIDIA,
and `scan.nix` is what was generated from the hardware scan when installing.

You may also change [`system/users.nix`](./system/users.nix), if you prefer.
