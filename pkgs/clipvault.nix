{
  lib,
  rustPlatform,
  inputs,
  ...
}:

rustPlatform.buildRustPackage rec {
  pname = "clipvault";
  version = "1.1.1";

  src = inputs.clipvault;

  cargoLock.lockFile = "${src}/Cargo.lock";

  doCheck = false; # upstream tests flaky in Nix builds

  meta = with lib; {
    description = "Clipboard history manager for Wayland";
    homepage = "https://github.com/Rolv-Apneseth/clipvault";
    license = licenses.agpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ ];
    mainProgram = "clipvault";
  };
}
