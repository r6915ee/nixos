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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Generic packages
    quickshell
    gpu-screen-recorder
    brightnessctl
    ddcutil
    cliphist
    matugen
    cava
    wlsunset
    xdg-desktop-portal
    grim
    vscodium-fhs
    slurp
    # mako
    imagemagick
    waybar
    swaybg
    waytrogen
    fuzzel
    neovim
    scite
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
    alacritty
    plasma-panel-colorizer
    ghostty
    krita
    rare
    legcord
    http-server
    polkit
    soteria
    psmisc
    tlrc
    alsa-oss
    yewtube
    nixfmt
    seahorse
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
    lazygit
    zellij
    eza
    starship
    audacity
    gh
    nil
    nixd
    marksman
    gparted
    libsForQt5.qoauth
    libsForQt5.signond
    liboauth
    mdl
    fastfetch
    nixgl.auto.nixGLNvidia
    nixgl.auto.nixVulkanNvidia
    wineWowPackages.stable
    winetricks
    wineWowPackages.waylandFull
    zed-editor
    glow

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
