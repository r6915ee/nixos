{ pkgs, ... }:
let
  nixgl = import <nixgl> { };
in
{
  imports = [
    # KDE package set
    ./sets/kde.nix
  ];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (final: prev: {
      noctalia-shell = pkgs.callPackage ./custom/noctalia-shell.nix { };
    })
  ];

  environment.etc = {
    "xdg/quickshell/noctalia-shell".source =
      "${pkgs.noctalia-shell.out}/etc/xdg/quickshell/noctalia-shell";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Generic packages
    quickshell
    noctalia-shell
    gpu-screen-recorder
    kdePackages.qtmultimedia
    brightnessctl
    ddcutil
    cliphist
    cabextract
    matugen
    nautilus
    cava
    wlsunset
    obsidian
    xdg-desktop-portal
    vscodium-fhs
    imagemagick
    neovim
    mpv
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
    http-server
    polkit
    soteria
    psmisc
    tlrc
    yewtube
    nixfmt
    wl-clipboard-rs
    openssl
    yazi
    rar
    spotify
    gnome-software
    libsignon-glib
    speechd
    nix-search-tv
    gitui
    nix-index
    qt6Packages.qtstyleplugin-kvantum
    vim
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
    rusty-man
    ripgrep
    papirus-icon-theme
    itch
    inxi
    wget
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
    helix
    ffmpeg
    lldb
    zellij
    audacity
    gh
    nil
    nixd
    gparted
    libsForQt5.qoauth
    libsForQt5.signond
    liboauth
    fastfetch
    nixgl.auto.nixGLNvidia
    nixgl.auto.nixVulkanNvidia
    wineWowPackages.stable
    winetricks
    wineWowPackages.waylandFull
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
