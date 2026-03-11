{
  inputs,
  den,
  lib,
  ...
}:
{
  imports = [ inputs.den.flakeModule ];

  den.ctx.user.classes = lib.mkDefault [ "homeManager" ];

  den.hosts.x86_64-linux.nf.users.kolya = { };

  den.aspects.nf = {
    includes = [ den.provides.hostname ];
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.hello ];
      };
  };

  den.aspects.kolya = {
    includes = [
      den.provides.define-user
      den.provides.primary-user
    ];
    homeManager =
      { pkgs, ... }:
      {
        packages = [ pkgs.vim ];
      };
  };
}
