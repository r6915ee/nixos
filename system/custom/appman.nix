{
  pkgs,
}:
let
  mainPkg = pkgs.stdenv.mkDerivation rec {
    name = "appman-unwrapped";
    src = pkgs.fetchFromGitHub {
      owner = "ivan-hc";
      repo = "AM";
      rev = "27d3e686af072852e9c3c03248186c4f6ce986fb";
      hash = "sha256-nsOKBEPcfFbgGJxAE6wAcOYekDtr8m7ACjVORzIyDCQ=";
    };
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
