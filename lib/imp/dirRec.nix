let
  filterFiles = import ../common/filterFiles.nix;

  paths = {
    dir,
    structured ? false,
    filters ? [],
  }: let
    # [{ path: Path, name: String: type: "directory" }]
    directories = filterFiles {
      inherit dir filters;
      types = ["directory"];
    };
    # [{ path: Path, name: String: type: "regular" }]
    allNixFiles = filterFiles {
      inherit dir filters;
      types = ["regular"];
      extensions = ["nix"];
    };
    # [{ path: Path, name: String: type: "regular" }]
    defaultNixFile = builtins.filter (file: file.name == "default") allNixFiles;
    # [{ path: Path, name: String: type: "regular" }]
    nixFiles =
      if defaultNixFile == []
      then allNixFiles
      else defaultNixFile;
  in
    if structured
    then let
      # [{name: String, value: Path}]
      structuredNixFiles =
        builtins.map (file: {
          name = file.name;
          value = file.path;
        })
        nixFiles;
      # [{name: String, value: recursive}]
      fromDirs =
        if defaultNixFile == []
        then
          builtins.map (file: {
            name = file.name;
            value = paths {
              dir = file.path;
              inherit structured;
            };
          })
          directories
        else [];
    in
      builtins.listToAttrs (structuredNixFiles ++ fromDirs)
    else let
      fromDirs =
        if defaultNixFile == []
        then builtins.map (file: paths file.path) directories
        else [];
    in
      nixFiles ++ builtins.concatLists fromDirs;

  imp = {
    dir,
    structured ? false,
    filters ? []
  }: let
    importPaths = paths {inherit dir structured filters;};
  in
    if structured
    then let
      mapAttr = name: val:
        if builtins.isPath val
        then import val
        else builtins.mapAttrs mapAttr val;
    in
      builtins.mapAttrs mapAttr importPaths
    else let
      map = path: import path;
    in
    if builtins.pathExists dir then
      builtins.map map importPaths
    else  {};
in {
  inherit imp paths;
}
