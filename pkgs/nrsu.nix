{ writeShellScriptBin }:

writeShellScriptBin "nrsu" ''
  nix flake update --flake ~/nix-configs "$@"
  sudo nixos-rebuild switch --flake ~/nix-configs#$NIX_HOST
'' // { meta.description = "Update flake inputs and rebuild NixOS configuration"; }