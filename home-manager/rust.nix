{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [];

  nixpkgs = {
    overlays = [
      inputs.rust-overlay.overlays.default
    ];
    config = {
      allowUnfree = true;
    };
  };

  home.packages = with pkgs; [
    (rust-bin.beta.latest.default.override
      {
        extensions = ["rust-src"];
      })
  ];
}
