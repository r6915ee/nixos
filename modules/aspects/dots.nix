let
  __fn =
    config: lib: user: files: dirs:
    let

      inherit (config.lib.file) mkOutOfStoreSymlink;
      inherit (lib) mergeAttrsList;

      toSrcFileRelative =
        name: shared:
        let
          core = if shared == true then "shared" else "${user.name}/dotfiles";
        in
        "${core}/${name}";

      root = "/etc/nixos/modules/users";
      toSrcFileRooted = name: shared: "${root}/${toSrcFileRelative name shared}";

      link = name: shared: mkOutOfStoreSymlink (toSrcFileRooted name shared);

      resolve = file: rec {
        filepath = if file ? "path" then file.path else file;
        is-shared = if file ? "shared" then file.shared else false;
        is-symlinked = if file ? "symlinked" then file.symlinked else false;
        source =
          if is-symlinked then link filepath is-shared else ../users/${toSrcFileRelative filepath is-shared};
      };

      linkFile = file: {
        ${if file ? "path" then file.path else file}.source = (resolve file).source;
      };

      linkDir = file: {
        ${if file ? "path" then file.path else file} = {
          source = (resolve file).source;
          recursive = true;
        };
      };

      confFiles = map linkFile files;
      confDirs = map linkDir dirs;
    in
    mergeAttrsList (confFiles ++ confDirs);
in
{
  # Compilation performance is not a concern here, so this aspect uses the
  # array of structures formula.
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
