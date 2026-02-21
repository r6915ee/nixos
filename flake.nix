{
  description = "Extremely basic system flake... maybe?";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
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
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      dms,
      ...
    }:
    {
      nixosConfigurations.NF2025 = nixpkgs.lib.nixosSystem {
        specialArgs = rec {
          inherit inputs;
          getCustomInputPackage =
            input: arch: package:
            (inputs."${input}".packages."${arch}"."${package}");
          getInputPackage = input: getCustomInputPackage "${input}" "x86_64-linux" "default";
        };
        modules = [
          ./configuration.nix
          dms.nixosModules.greeter
          home-manager.nixosModules.home-manager
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
