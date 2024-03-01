{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [inputs.spicetify.homeManagerModules.default];

  programs.spicetify = let
    spicePkgs = inputs.spicetify.legacyPackages.${pkgs.system};
  in {
    enable = false;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle
      hidePodcasts
    ];
  };
}
