let
  recursivePaths =
    dir:
    let
      fileExtension =
        path:
        builtins.baseNameOf path
        |> builtins.split "\\."
        |> (parts: builtins.elemAt parts ((builtins.length parts) - 1))
        |> (extension: if extension == [ ] then "" else extension);

      ls =
        builtins.readDir dir
        |> builtins.mapAttrs (name: type: { inherit name type; })
        |> builtins.attrValues;

      toPath = file: /${dir}/${file.name};

      directories = ls |> builtins.filter (file: file.type == "directory");
      pathsFromDirectories =
        directories |> builtins.map (file: file |> toPath |> recursivePaths) |> builtins.concatLists;

      nixFiles =
        ls
        |> builtins.filter (file: file.type == "regular")
        |> builtins.filter (file: fileExtension file.name == "nix");

      defaultNix = nixFiles |> builtins.filter (file: file.name == "default.nix");

      nixPaths = nixFiles |> builtins.map toPath;
      defaultNixPath = defaultNix |> builtins.map toPath;
    in
    if builtins.length defaultNix > 0 then defaultNixPath else nixPaths ++ pathsFromDirectories;
in
recursivePaths
