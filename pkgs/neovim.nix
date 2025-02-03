{ inputs, pkgs, ... }:
{
  nvim = inputs.nvim-flake.packages.${pkgs.system}.nvim;
  nvimdev = inputs.nvim-flake.packages.${pkgs.system}.nvimdev;
}
