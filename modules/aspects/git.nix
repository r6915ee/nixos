{
  den.aspects.git = {
    nixos.programs.git = {
      enable = true;
      config.safe.directory = "*";
    };

    provides.to-user.homeManager =
      { pkgs, ... }:
      {
        programs = {
          git = {
            enable = true;
            package = pkgs.gitFull;
            settings = {
              user = {
                name = "r6915ee";
                email = "astergthefourth@gmail.com";
              };
              credential = {
                helper = "libsecret";
              };
            };
          };
          jujutsu = {
            enable = true;
            settings = {
              user = {
                name = "r6915ee";
                email = "astergthefourth@gmail.com";
              };
            };
          };
        };
      };
  };
}
