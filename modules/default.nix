{
  den.default = {
    provides.to-hosts.nixos =
      { pkgs, ... }:
      {
        home-manager.backupFileExtension = "bkp";

        nixpkgs.config.allowUnfree = true;
        environment.localBinInPath = true;
        environment.sessionVariables = rec {
          COSMIC_DATA_CONTROL_ENABLED = 1;
          QS_ICON_THEME = "Papirus-Dark";
          FLAKE = "/etc/nixos";
          NH_FLAKE = FLAKE;
        };
        environment.systemPackages = with pkgs; [
          nixos-facter
          inxi
          cachix
        ];
        boot.loader.efi.canTouchEfiVariables = true;
        nix.settings = {
          trusted-users = [ "decky" ];
          experimental-features = [
            "nix-command"
            "flakes"
          ];
        };
        boot.kernelPackages = pkgs.linuxPackages_zen;
        # security.sudo.enable = false;
        security.doas = {
          enable = true;
          extraRules = [
            {
              users = [
                "kolya"
                "decky"
              ];
              keepEnv = true;
              persist = true;
            }
          ];
        };
        services.fwupd.enable = true;
        time.timeZone = "America/Los_Angeles";
        i18n.defaultLocale = "en_US.UTF-8";
        i18n.extraLocaleSettings = {
          LC_ADDRESS = "en_US.UTF-8";
          LC_IDENTIFICATION = "en_US.UTF-8";
          LC_MEASUREMENT = "en_US.UTF-8";
          LC_MONETARY = "en_US.UTF-8";
          LC_NAME = "en_US.UTF-8";
          LC_NUMERIC = "en_US.UTF-8";
          LC_PAPER = "en_US.UTF-8";
          LC_TELEPHONE = "en_US.UTF-8";
          LC_TIME = "en_US.UTF-8";
        };
      };
    provides.to-users.homeManager.nixpkgs.config.allowUnfree = true;
  };
}
