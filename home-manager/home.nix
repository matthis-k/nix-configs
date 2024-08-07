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
    ./nvim
    ./theme.nix
    ./spicetify.nix
    ./kitty
    ./ags
    ./rust.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      inputs.nur.overlay
      inputs.rust-overlay.overlays.default
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      permittedInsecurePackages = [
        "nix-2.16.2"
        "electron-24.8.6"
      ];
    };
  };

  home.packages = with pkgs; [
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
