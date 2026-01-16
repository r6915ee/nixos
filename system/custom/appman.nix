{
  pkgs,
}:
let
  mainPkg = pkgs.stdenv.mkDerivation rec {
    name = "appman-unwrapped";
    src = fetchTarball "https://github.com/ivan-hc/AM/archive/refs/heads/main.tar.gz";
    installPhase = ''
      mkdir -p $out/bin
      install -m +x ${src}/APP-MANAGER $out/bin/appman
    '';
  };
in
# Needed in order to support user namespaces.
pkgs.buildFHSEnv {
  name = "appman";
  targetPkgs =
    pkgs: with pkgs; [
      mainPkg
      curl
      wget
      binutils
      less
      unzip
      zsync
    ];
  runScript = "${mainPkg}/bin/appman";
}
