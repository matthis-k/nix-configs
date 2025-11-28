{ writeShellScriptBin }:

writeShellScriptBin "nrs" ''
  sudo nixos-rebuild switch --flake ~/nix-configs#$NIX_HOST
'' // { meta.description = "Rebuild NixOS configuration"; }