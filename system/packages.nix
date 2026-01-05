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
    obsidian
    xdg-desktop-portal
    vscodium-fhs
    imagemagick
    neovim
    mpv
    tinty
    icu
    file
    virtualgl
    libreoffice-qt6-fresh
    hunspell
    hunspellDicts.en_US
    sgdboop
    techmino
    osu-lazer-bin
    # Needed for gtk-launch
    gtk3
    plasma-panel-colorizer
    krita
    rare
    legcord
    rustlings
    http-server
    polkit
    soteria
    psmisc
    tlrc
    yewtube
    nixfmt
    wl-clipboard-rs
    openssl
    rar
    spotify
    gnome-software
    # libsignon-glib
    speechd
    qt6Packages.qtstyleplugin-kvantum
    chawan
    asciinema
    asciinema-agg
    btop
    zenity
    efibootmgr
    OVMF
    qemu
    quickemu
    codeberg-cli
    pciutils
    ripgrep
    papirus-icon-theme
    # itch
    inxi
    xwayland-satellite
    cosmic-ext-ctl
    # libresprite
    vulkan-loader
    vulkan-validation-layers
    package-version-server
    vulkan-tools
    vlc
    nss
    bat
    ffmpeg
    lldb
    zellij
    audacity
    nil
    nixd
    gparted
    libsForQt5.qoauth
    libsForQt5.signond
    liboauth
    fastfetch
    wineWow64Packages.stagingFull
    winetricks
    umu-launcher
    wineWow64Packages.waylandFull
    zed-editor

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
        xorg.libXdamage
      ];
      extraPkgs = pkgs: [
        vlc
      ];
    })
  ];
}
