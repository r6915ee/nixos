let
  __fn =
    config: lib: user: files: dirs:
    let

      inherit (config.lib.file) mkOutOfStoreSymlink;
      inherit (lib) mergeAttrsList;

      root = "/etc/nixos/modules/users";
      toSrcFile =
        name:
        let
          base = builtins.substring 0 2 name;
          core = if base == "s:" then "shared" else "${user.name}/dotfiles";
          suffix =
            if base == "s:" then builtins.substring 2 ((builtins.stringLength name) - 2) name else name;
        in
        "${root}/${core}/${suffix}";

      link = name: mkOutOfStoreSymlink (toSrcFile name);

      linkFile = name: {
        ${name}.source = link name;
      };

      linkDir = name: {
        ${name} = {
          source = link name;
          recursive = true;
        };
      };

      confFiles = map linkFile files;
      confDirs = map linkDir dirs;
    in
    mergeAttrsList (confFiles ++ confDirs);
in
{
  den.aspects.dots =
    files: dirs:
    { user }:
    {
      homeManager =
        { config, lib, ... }:
        {
          xdg.configFile = (__fn config lib user files dirs);
        };
    };
}
