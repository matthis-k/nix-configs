{
  description = "Best flake ever";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nvim-flake.url = "github:matthis-k/nvim-flake";
    nvim-flake.inputs.nixpkgs.follows = "nixpkgs";

    ags.url = "github:aylur/ags";
    ags.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      lib = import ./lib;
      packages = nixpkgs.lib.genAttrs [ "x86_64-linux" ] (
        system: let
        pkgs = nixpkgs.legacyPackages.${system};
        res = builtins.mapAttrs (
          name: package:
          package { inherit inputs system pkgs lib ; }
        ) (lib.dirRec.imp {dir = ./pkgs; structured = true;});
        in
        { default = inputs.nvim-flake.packages.x86_64-linux.nvim; } );
    in
    {
      inherit lib packages;
    };
}
