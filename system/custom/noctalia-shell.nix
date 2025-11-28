{ pkgs }:
pkgs.stdenv.mkDerivation rec {
  pname = "noctalia-shell";
  version = "3.4.0";
  src = pkgs.fetchgit {
    url = "https://github.com/noctalia-dev/noctalia-shell.git";
    tag = "v${version}";
    hash = "sha256-eTkt9C9nck0d8o2tNePO9eU/jG3o5FC5lMYS7NT6IPg=";
  };
  dontConfigure = true;
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/etc/xdg/quickshell/noctalia-shell
    cp -r $src/* $out/etc/xdg/quickshell/noctalia-shell
  '';
}
