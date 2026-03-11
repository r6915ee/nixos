{
  den.aspects.NF2025.nixos = {
    boot = {
      plymouth = {
        enable = true;
        theme = "bgrt";
      };

      consoleLogLevel = 3;
      kernelParams = [
        "quiet"
        "splash"
        "rd.systemd.show_status=auto"
      ];
      loader.systemd-boot.enable = true;
    };
  };
}
