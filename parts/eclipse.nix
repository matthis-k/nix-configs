{
  homeManager =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.eclipses.eclipse-jee ];
    };
}
