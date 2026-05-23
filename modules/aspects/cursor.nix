{
  den.aspects.cursor.homeManager =
    { pkgs, ... }:
    {
      home.pointerCursor = {
        enable = true;
        x11.enable = true;
        gtk.enable = true;
        dotIcons.enable = true;
        name = "macOS";
        package = pkgs.apple-cursor;
      };
    };
}
