{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  # add the home manager module
  imports = [inputs.ags.homeManagerModules.default];
  home.packages = with pkgs; [bun sassc uniq-proc];

  home.activation.linkAgsConfig =
    lib.hm.dag.entryAfter ["writeBoundary"]
    ''
      rm -rf ${config.home.homeDirectory}/.config/ags
      ln -s ${config.home.homeDirectory}/nix-configs/configs/ags ${config.home.homeDirectory}/.config/ags
    '';
  programs.ags = {
    enable = true;
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };
}
