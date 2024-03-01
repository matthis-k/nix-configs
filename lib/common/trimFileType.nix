path: let
  basename = builtins.baseNameOf path;
  parts = builtins.split ''\.'' basename;
  removeLastElemKeepMinOne = xs: let
    len = builtins.length parts;
    n =
      if len > 1
      then len - 1
      else 1;
  in
    builtins.genList (i: builtins.elemAt xs i) n;
  result = builtins.concatStringsSep ''.'' (builtins.filter (e: !builtins.isList e) (removeLastElemKeepMinOne parts));
in
  result
