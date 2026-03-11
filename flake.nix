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

      inherit (den.den.hosts.x86_64-linux) NF2025;
    in
    {
      nixosConfigurations.NF2025 = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          inputs.dms.nixosModules.greeter
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
          }
          NF2025.mainModule
        ];
      };
    };
}
