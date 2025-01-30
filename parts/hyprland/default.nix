{
  homeManager =
    { pkgs, ... }:
    {
      imports = [
        ./settings.nix
      ];
      wayland.windowManager.hyprland.enable = true;
      wayland.windowManager.hyprland.systemd.enable = false;
      home.packages = with pkgs; [
      ];
    };
}
