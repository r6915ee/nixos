{
  description = "Extremely basic system flake... maybe?";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    templato = {
      url = "git+https://codeberg.org/r6915ee/templato";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devenv.url = "github:cachix/devenv/main";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    import-tree.url = "github:vic/import-tree";
    flake-aspects.url = "github:vic/flake-aspects";
    den.url = "github:vic/den";
  };

  outputs =
    inputs:
    let
      lib = inputs.nixpkgs.lib;
      den =
        (inputs.nixpkgs.lib.evalModules {
          modules = [
            (lib.pipe inputs.import-tree [
              (i: i.filterNot (lib.hasInfix "custom"))
              (i: i.filterNot (lib.hasInfix "dotfiles"))
              (i: i ./modules)
            ])
          ];
          specialArgs.inputs = inputs;
        }).config;
    in
    {
      inherit (den.flake) nixosConfigurations;
    };
}
