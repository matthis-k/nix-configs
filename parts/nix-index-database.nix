{
  nixos =
    { inputs, pkgs, ... }:
    {
      imports = [ inputs.nix-index-database.nixosModules.nix-index ];
      programs.nix-index-database.comma.enable = true;
      programs.nix-index.enable = true;
    };
  homeManager =
    {
      pkgs,
      nix-index-database,
      ...
    }:
    {
      imports = [ nix-index-database.homeModules.nix-index ];
      programs.nix-index.enable = true;
      programs.nix-index.symlinkToCacheHome = true;
    };
}
