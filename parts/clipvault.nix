{
  nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.locallyDefined.clipvault ];
    };
  homeManager =
    { ... }:
    {
    };
}
