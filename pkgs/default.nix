{
  pkgs,
  color,
  ...
}: let
  launchpad = let
    patched-config = color.files pkgs ./launchpad/config.rasi;
    patched-theme = color.files pkgs ./launchpad/theme.rasi;
  in {
    pkg = pkgs.writeScriptBin "launchpad" ''
      #!${pkgs.stdenv.shell}
      pkill rofi || ${pkgs.rofi}/bin/rofi -config ${patched-config} -theme ${patched-theme} -show drun
    '';
  };
in {
  launchpad = launchpad.pkg;
}
