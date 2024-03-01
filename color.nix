let
  palette = {
    base = "#1e1e2e"; #1e1e2e
    blue = "#89b4fa"; #89b4fa
    crust = "#11111b"; #11111b
    flamingo = "#f2cdcd"; #f2cdcd
    green = "#a6e3a1"; #a6e3a1
    lavender = "#b4befe"; #b4befe
    mantle = "#181825"; #181825
    maroon = "#eba0ac"; #eba0ac
    mauve = "#cba6f7"; #cba6f7
    overlay0 = "#6c7086"; #6c7086
    overlay1 = "#7f849c"; #7f849c
    overlay2 = "#9399b2"; #9399b2
    peach = "#fab387"; #fab387
    pink = "#f5c2e7"; #f5c2e7
    red = "#f38ba8"; #f38ba8
    rosewater = "#f5e0dc"; #f5e0dc
    sapphire = "#74c7ec"; #74c7ec
    sky = "#89dceb"; #89dceb
    subtext0 = "#a6adc8"; #a6adc8
    subtext1 = "#bac2de"; #bac2de
    surface0 = "#313244"; #313244
    surface1 = "#45475a"; #45475a
    surface2 = "#585b70"; #585b70
    teal = "#94e2d5"; #94e2d5
    txt = "#cdd6f4"; #cdd6f4
    yellow = "#f9e2af"; #f9e2af
  };
in rec {
  inherit palette;
  files = pkgs: target: pkgs.substituteAll (palette // {src = target;});
  fileToString = pkgs: target: builtins.readFile (files pkgs target);
}
