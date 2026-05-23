{
  den.aspects.custom.boot.nixos = {
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
      loader.limine.enable = true;
    };
  };
}
