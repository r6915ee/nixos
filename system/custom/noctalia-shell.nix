{ pkgs }:
pkgs.stdenv.mkDerivation rec {
  pname = "noctalia-shell";
  version = "3.5.0";
  src = pkgs.fetchgit {
    url = "https://github.com/noctalia-dev/noctalia-shell.git";
    tag = "v${version}";
    hash = "sha256-h94W20ZYS2HF1tSV7ZfZQf4Tsj9/0wofkBiRlepG/io=";
  };
  dontConfigure = true;
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/etc/xdg/quickshell/noctalia-shell
    cp -r $src/* $out/etc/xdg/quickshell/noctalia-shell
  '';
}
