{ ... }:
{
  imports = [
    ./settings.nix
  ];
  wayland.windowManager.hyprland.enable = true;
  home.packages = [
  ];
}
