{ den, ... }:
{
  den.aspects.decky = {
    includes = [
      den.provides.define-user
      den.provides.primary-user
      den.aspects.cursor
      (den.provides.user-shell "fish")
      den.aspects.systematic

      den.aspects.programs.fish
      den.aspects.programs.rio

      (den.aspects.dots [ "niri/config.kdl" ] [ ])

      (den.aspects.flatpak [
        "org.srb2.SRB2"
        "org.vinegarhq.Sober"
        "org.kartkrew.RingRacers"
        "com.vysp3r.ProtonPlus"
        "app.zen_browser.zen"
        "com.github.tchx84.Flatseal"
      ])
    ];

    homeManager =
      { pkgs, ... }:
      {
        home = {
          username = "decky";
          homeDirectory = "/home/decky";
          stateVersion = "25.11";
          packages = with pkgs; [
            sgdboop
            nemo
          ];
        };
      };
  };
}
