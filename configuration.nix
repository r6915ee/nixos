# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports =
    [
      # Use generic services.
      # NOTE: Hardware-related services, specifically NVIDIA,
      # are handled through their respective Nix file
      # instead.
      ./system/services.nix
      # Include the results of the hardware scan.
      ./hardware/scan.nix
      # Set up the hardware attribute.
      ./hardware/configuration.nix
      # Manage users.
      ./system/users.nix
      # Manage fonts.
      ./system/fonts.nix
      # Manage system packages.
      ./system/packages.nix
      # Manage common programs.
      ./system/programs.nix
      # Handle networking.
      ./system/networking.nix
      # Set up Distrobox.
      ./misc/distrobox.nix
      # Set up virt-manager.
      ./misc/virt-manager.nix
      # Set up env. variables.
      ./system/environment.nix
      # Configure Plymouth.
      ./misc/plymouth.nix
      # Configure time and locale.
      ./system/time-locale.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Experimental features
  nix.settings.experimental-features = ["nix-command"];
  
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
