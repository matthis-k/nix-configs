# returns { path: Path, name: String: type: regular|directory|symlink|unkown }
{
  filters ? [],
  hidden ? false,
  extensions ? [],
  types ? [],
  dir,
}: let
  trimFileType = import ./trimFileType.nix;
  fileList = let
    list = builtins.readDir dir;
    pathAndType =
      builtins.mapAttrs (path: type: let
        absPath = /${dir}/${path};
      in {
        inherit type;
        path = absPath;
        name = trimFileType absPath;
      })
      list;
  in
    builtins.attrValues pathAndType;

  hiddenFilter = [
    (file: let
      isHidden = (builtins.match ''^\..*$'' (builtins.baseNameOf file.path)) != null;
    in
      !isHidden || hidden)
  ];

  extensionsFilter =
    if extensions == []
    then []
    else [(file: builtins.any (extension: builtins.match ''^.*\.${extension}$'' (builtins.toString file.path) != null) extensions)];

  typeFilter = [(file: builtins.elem file.type types)];

  allFilters =
    filters
    ++ typeFilter
    ++ hiddenFilter
    ++ extensionsFilter;

  applyAllFilters = file: builtins.all (filter: filter file) allFilters;
in
  builtins.filter applyAllFilters fileList
