{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  home.packages = [
    (inputs.nvim-flake.packages.${pkgs.system}.nvim)
  ];
}
