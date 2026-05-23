{ inputs, ... }:
{
  den.aspects.flatpak =
    packages:
    let
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
    in
    { class, ... }:
    {
      ${class} =
        {
          "nixos" = {
            imports = [
              inputs.nix-flatpak.nixosModules.nix-flatpak
            ];

            services.flatpak = {
              enable = true;
              inherit packages remotes;
            };
          };
          "homeManager" = {
            imports = [
              inputs.nix-flatpak.homeManagerModules.nix-flatpak
            ];

            services.flatpak = {
              inherit packages remotes;
            };
          };
        }
        .${class};
    };
}
