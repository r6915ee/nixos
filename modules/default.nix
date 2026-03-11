{
  den.default.nixos =
    { pkgs, ... }:
    {
      system.stateVersion = "25.05";
      nixpkgs.config.allowUnfree = true;
      environment.localBinInPath = true;
      environment.sessionVariables = {
        COSMIC_DATA_CONTROL_ENABLED = 1;
        QS_ICON_THEME = "Papirus-Dark";
      };
      environment.systemPackages = with pkgs; [
        nixos-facter
      ];
      boot.loader.efi.canTouchEfiVariables = true;
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      boot.kernelPackages = pkgs.linuxPackages_latest;
    };
  den.default.homeManager.home.stateVersion = "25.05";
}
