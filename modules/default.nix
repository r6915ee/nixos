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
      boot.kernelPackages = pkgs.linuxPackages_zen;
      security.sudo.enable = false;
      security.doas = {
        enable = true;
        extraRules = [
          {
            users = [ "kolya" ];
            keepEnv = true;
            persist = true;
          }
        ];
      };
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
  den.default.homeManager.home.stateVersion = "25.05";
}
