{ pkgs }:
pkgs.stdenv.mkDerivation rec {
  pname = "noctalia-shell";
  version = "3.6.2";
  src = pkgs.fetchgit {
    url = "https://github.com/noctalia-dev/noctalia-shell.git";
    tag = "v${version}";
    hash = "sha256-2vmjE1RD0ky+LkFQ1tUChfDQF9984o4ntFXIks0P7m8=";
  };
  dontConfigure = true;
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/bin
    cp -r $src/* $out/bin/
  '';
}
