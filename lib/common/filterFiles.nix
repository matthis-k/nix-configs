{
  filters ? [],
  hidden ? false,
  extensions ? [],
  types ? [],
  dir,
}: let

  trimFileType = import ./trimFileType.nix;

  fileList =
    dir
    |> builtins.readDir
    |> (list: builtins.mapAttrs
      (path: type: let
         absPath = "/${dir}/${path}";
       in {
         inherit type;
         path = absPath;
         name = trimFileType absPath;
       })
      list
    )
    |> builtins.attrValues;

  hiddenFilter = [
    (file:
      let
        baseName = builtins.baseNameOf file.path;
        isHidden = (builtins.match ''^\..*$'' baseName) != null;
      in
        !isHidden || hidden
    )
  ];

  extensionsFilter =
    if extensions == [] then
      []
    else [
      (file:
        builtins.any (extension:
          builtins.match ''^.*\.${extension}$'' (builtins.toString file.path) != null
        ) extensions
      )
    ];

  typeFilter = [(file: builtins.elem file.type types)];

  allFilters =
    filters
    ++ typeFilter
    ++ hiddenFilter
    ++ extensionsFilter;

  applyAllFilters = file: builtins.all (filter: filter file) allFilters;
in
  fileList
  |> builtins.filter applyAllFilters
