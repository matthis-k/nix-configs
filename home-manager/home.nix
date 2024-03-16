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
    inputs.hyprlock.homeManagerModules.default
    ./fish
    ./firefox.nix
    ./hyprland
    ./nvim
    ./theme.nix
    ./spicetify.nix
    ./waybar
    ./kitty
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      inputs.nur.overlay
      inputs.nix-software-center.overlay
      inputs.neovim-nightly-overlay.overlay
      inputs.rust-overlay.overlays.default
    ];
    config = {
      allowUnfree = true;
    };
  };

  home.packages = with pkgs; [
    nix-software-center
    libreoffice
    steam
    nix-output-monitor
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "nix-2.16.2"
  ];

  home = rec {
    username = "matthisk";
    homeDirectory = "/home/matthisk";
  };

  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.git.userEmail = "matthis.kaelble@gmail.com";
  programs.git.userName = "matthis-k";

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";
}
