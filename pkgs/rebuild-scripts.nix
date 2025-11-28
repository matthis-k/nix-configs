{ writeShellScriptBin }:

{
  nrs = writeShellScriptBin "nrs" ''
    sudo nixos-rebuild switch --flake ~/nix-configs#$NIX_HOST
  '' // { meta.description = "Rebuild NixOS configuration"; };

  nrsu = writeShellScriptBin "nrsu" ''
    nix flake update "$@"
    sudo nixos-rebuild switch --flake ~/nix-configs#$NIX_HOST
  '' // { meta.description = "Update flake inputs and rebuild NixOS configuration"; };
}