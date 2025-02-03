path: let
  removeLastElemKeepMinOne =
    xs: let
      len = builtins.length xs;
      n = if len > 1 then len - 1 else 1;
    in
      builtins.genList (i: builtins.elemAt xs i) n;
in
  path
  |> builtins.baseNameOf
  |> builtins.split "\\."
  |> removeLastElemKeepMinOne
  |> builtins.filter (e: ! builtins.isList e)
  |> builtins.concatStringsSep "."
