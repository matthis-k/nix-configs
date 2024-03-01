{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [];

  home.packages = with pkgs; [
    (rust-bin.beta.latest.default.override
      {
        extensions = ["rust-src"];
      })
  ];
}
