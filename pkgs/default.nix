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
  uniq-proc = pkgs.rustPlatform.buildRustPackage {
    pname = "uniq-proc";
    version = "0.1.0";

    src = ./uniq-proc;
    cargoLock = {lockFile = ./uniq-proc/Cargo.lock;};

    meta = {
      description = "Tool to manage a few defined processes.";
      license = pkgs.lib.licenses.unlicense;
      maintainers = [];
    };
  };
}
