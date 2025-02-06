{
  homeManager =
    { ... }:
    {
      xdg.configFile."wallpaper.png" = {
        enable = true;
        source = ../assets/wallpaper.png;
      };
    };
}
