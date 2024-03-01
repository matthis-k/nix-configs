{inputs, pkgs, lib, system, ...}: let
    neovim = inputs.nvim-flake.packages.${system}.nvim;
    in {
        neovim = builtins.trace "called" neovim;
}
