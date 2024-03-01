{
  pkgs,
  color,
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
}
