{ pkgs }:
pkgs.stdenv.mkDerivation rec {
  pname = "noctalia-shell";
  version = "3.7.2";
  src = pkgs.fetchgit {
    url = "https://github.com/noctalia-dev/noctalia-shell.git";
    tag = "v${version}";
    hash = "sha256-f6xyNuXSwRo4Gjeiycf5cFlA4Vu+qeyGIOmR8txuN8o=";
  };
  dontConfigure = true;
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/bin
    cp -r $src/* $out/bin/
  '';
}
