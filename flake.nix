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
      den =
        (inputs.nixpkgs.lib.evalModules {
          modules = [ (inputs.import-tree ./modules) ];
          specialArgs.inputs = inputs;
        }).config;

      inherit (den.den.hosts.x86_64-linux) nf;
    in
    {
      nixosConfigurations.NF2025 = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = rec {
          inherit inputs;
          getCustomInputPackage =
            input: arch: package:
            (inputs.${input}.packages.${arch}.${package});
          getInputPackage = input: getCustomInputPackage input "x86_64-linux" "default";
        };
        modules = [
          ./configuration.nix
          inputs.dms.nixosModules.greeter
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.kolya = import ./system/home.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };
    };
}
