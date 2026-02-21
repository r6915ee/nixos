{ pkgs, lib, ... }:
{
  imports = [
    # KDE package set
    ./sets/kde.nix
  ];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # UUtils
    (lib.hiPrio uutils-coreutils-noprefix)
    (lib.hiPrio uutils-findutils)
    (lib.hiPrio uutils-diffutils)
    # Generic packages
    quickshell
    zip
    unzip
    gpu-screen-recorder
    kdePackages.qtmultimedia
    brightnessctl
    ddcutil
    cliphist
    cabextract
    matugen
    nautilus
    wget
    cava
    wlsunset
    xdg-desktop-portal
    imagemagick
    tinty
    icu
    file
    virtualgl
    hunspell
    hunspellDicts.en_US
    plasma-panel-colorizer
    rustlings
    http-server
    polkit
    soteria
    psmisc
    nixfmt
    wl-clipboard-rs
    openssl
    rar
    speechd
    qt6Packages.qtstyleplugin-kvantum
    btop
    zenity
    efibootmgr
    OVMF
    qemu
    quickemu
    pciutils
    papirus-icon-theme
    inxi
    xwayland-satellite
    vulkan-loader
    vulkan-validation-layers
    package-version-server
    vulkan-tools
    vlc
    nss
    ffmpeg
    lldb
    nil
    nixd
    gparted
    libsForQt5.qoauth
    libsForQt5.signond
    liboauth
    umu-launcher

    # Configure QEMU
    (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
      qemu-system-x86_64 \
        -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
        "$@"
    '')

    # Lutris
    (lutris.override {
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
}
