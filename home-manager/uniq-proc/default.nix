{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = with pkgs; [uniq-proc];

  home.activation.linkUniqProcConfig =
    lib.hm.dag.entryAfter ["writeBoundary"]
    ''
      rm -rf ${config.home.homeDirectory}/.config/uniq-proc
      ln -s ${config.home.homeDirectory}/nix-configs/configs/uniq-proc ${config.home.homeDirectory}/.config/uniq-proc
    '';
}
