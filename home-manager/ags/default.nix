{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  # add the home manager module
  imports = [inputs.ags.homeManagerModules.default];
  home.packages = with pkgs; [
    bun
    sassc
    wrapGAppsHook
    gobject-introspection
  ];

  /*
   home.activation.linkAgsConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
    rm -rf ${config.home.homeDirectory}/.config/ags
    ln -s ${config.home.homeDirectory}/nix-configs/configs/ags ${config.home.homeDirectory}/.config/ags
  '';
  */
  programs.ags = {
    enable = true;
    package = inputs.ags.packages.${pkgs.system}.agsFull;
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
      inputs.astal.packages.${system}.docs
      inputs.astal.packages.${system}.io
      inputs.astal.packages.${system}.gjs
      inputs.astal.packages.${system}.astal3
      inputs.astal.packages.${system}.astal4
      inputs.astal.packages.${system}.apps
      inputs.astal.packages.${system}.auth
      inputs.astal.packages.${system}.battery
      inputs.astal.packages.${system}.bluetooth
      inputs.astal.packages.${system}.cava
      inputs.astal.packages.${system}.greet
      inputs.astal.packages.${system}.hyprland
      inputs.astal.packages.${system}.mpris
      inputs.astal.packages.${system}.network
      inputs.astal.packages.${system}.notifd
      inputs.astal.packages.${system}.powerprofiles
      inputs.astal.packages.${system}.river
      inputs.astal.packages.${system}.tray
      inputs.astal.packages.${system}.wireplumber
    ];
  };
}
