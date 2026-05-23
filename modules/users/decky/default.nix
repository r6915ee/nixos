{ den, inputs, ... }:
{
  den.aspects.decky = {
    includes = [
      den.provides.define-user
      den.provides.primary-user
      (den.provides.user-shell "fish")
    ];

    homeManager =
      { pkgs, ... }:
      {
        imports = [
          inputs.dms.homeModules.dank-material-shell
          inputs.nix-flatpak.homeManagerModules.nix-flatpak
        ];

        home = {
          username = "decky";
          homeDirectory = "/home/decky";
          stateVersion = "25.11";
          packages = with pkgs; [
            sgdboop
            nemo
          ];
        };

        services.flatpak = {
          remotes = [
            {
              name = "flathub";
              location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
            }
            {
              name = "flathub-beta";
              location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
            }
          ];
        };
      };
  };
}
