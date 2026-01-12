{ pkgs }:
pkgs.stdenv.mkDerivation rec {
  pname = "noctalia-shell";
  version = "4.0.0";
  src = pkgs.fetchgit {
    url = "https://github.com/noctalia-dev/noctalia-shell.git";
    tag = "v${version}";
    hash = "sha256-1ByxRYrivSkD4lIQQxv88r+I/mFo+JF3ebok6375+3Q=";
  };
  dontConfigure = true;
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/bin
    cp -r $src/* $out/bin/
  '';
}
