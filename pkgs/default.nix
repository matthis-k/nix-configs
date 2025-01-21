{
  pkgs,
  color,
  inputs,
  ...
}: let
  launchpad = let
    patched-config = color.files pkgs ./launchpad/config.rasi;
    patched-theme = color.files pkgs ./launchpad/theme.rasi;
  in rec {
    pkg = pkgs.writeScriptBin "launchpad" ''
      #!${pkgs.stdenv.shell}
      ${pkgs.rofi-wayland}/bin/rofi -config ${patched-config} -theme ${patched-theme} -show drun
    '';
  };
in {
  launchpad = launchpad.pkg;

  hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
  ags = inputs.ags.packages.${pkgs.system}.agsFull;
  hyprlandPlugin.hyprexpo = inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo;
  hyprlandPlugin.hyprspace = inputs.Hyprspace.packages.${pkgs.system}.Hyprspace;
  firefox-nightly-bin = inputs.firefox-nightly.packages.${pkgs.system}.firefox-nightly-bin;
  nixovim = inputs.nvim-flake.packages.${pkgs.system}.nvim;
}
