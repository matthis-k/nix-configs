{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
    inputs.catppuccin.homeManagerModules.catppuccin
    ./fish
    ./firefox.nix
    ./hyprland
    ./theme.nix
    ./spicetify.nix
    ./kitty
    ./ags
    ./rust.nix
  ];

  home.packages = with pkgs; [
    libreoffice
    steam
    nix-output-monitor
    docker
    vscode-fhs

    nixovim
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

  home.stateVersion = "24.11";
}
