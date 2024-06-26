{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./fish
    ./firefox.nix
    ./hyprland
    ./nvim
    ./theme.nix
    ./spicetify.nix
    ./waybar
    ./kitty
    ./rust.nix
  ];

  home.packages = with pkgs; [
    nix-software-center
    libreoffice
    steam
    nix-output-monitor
    docker
    vscode-fhs
  ];

  home = {
    username = "matthisk";
    homeDirectory = "/home/matthisk";
  };

  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.git.userEmail = "matthis.kaelble@gmail.com";
  programs.git.userName = "matthis-k";

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.05";
}
