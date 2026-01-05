{ pkgs }:
pkgs.stdenv.mkDerivation rec {
  pname = "noctalia-shell";
  version = "3.8.2";
  src = pkgs.fetchgit {
    url = "https://github.com/noctalia-dev/noctalia-shell.git";
    tag = "v${version}";
    hash = "sha256-ZjtdQbVPHJeWP8VHWZmSwPwD6fC7Dqmknx1KErzfDks=";
  };
  dontConfigure = true;
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/bin
    cp -r $src/* $out/bin/
  '';
}
