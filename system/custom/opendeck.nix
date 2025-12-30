{
  pkgs,
}:
# Used for fetching the udev rules provided by the repo.
pkgs.stdenv.mkDerivation {
  name = "rust-elgato-streamdeck";
  src = fetchTarball "https://github.com/OpenActionAPI/rust-elgato-streamdeck/archive/refs/heads/main.tar.gz";
  dontConfigure = true;
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/etc/udev/rules.d
    cp -r $src/40-streamdeck.rules $out/etc/udev/rules.d/40-streamdeck.rules
  '';
}
