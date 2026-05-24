{
  den.aspects.systematic.homeManager.programs = {
    btop.enable = true;
    eza.enable = true;
    ripgrep.enable = true;
    bat.enable = true;
    fastfetch.enable = true;
    zoxide.enable = true;

    fish = {
      shellAliases = {
        "ls" = "eza";
      };
      shellAbbrs = {
        "cls" = "clear";
      };
    };
  };
}
