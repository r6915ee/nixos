{
  den.aspects.hardware = {
    nixos = {
      hardware = {
        graphics = {
          enable = true;
          enable32Bit = true;
        };

        bluetooth = {
          enable = true;
          powerOnBoot = true;
          settings = {
            General = {
              Experimental = true;
              FastConnectable = true;
            };
            Policy = {
              AutoEnable = true;
            };
          };
        };
      };
    };
  };
}
