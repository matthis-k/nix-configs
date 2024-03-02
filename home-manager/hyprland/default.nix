{
  inputs,
  pkgs,
  color,
  ...
}: {
  imports = [
    ./hyprlock.nix
    ./hyprland.nix
    ./swaync
  ];

  programs.waybar.enable = true;

  programs.rofi.enable = true;
  programs.rofi.package = pkgs.rofi-wayland;

  xdg.configFile."wallpaper.png".source = ./wallpaper.png;

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = /home/matthisk/.config/wallpaper.jpg
    wallpaper = ,/home/matthisk/.config/wallpaper.jpg
    unload = /home/matthisk/.config/wallpaper.jpg
    splash = false
  '';

  home.packages = with pkgs; [
    blueberry
    brightnessctl
    discord
    grimblast
    hyprpaper
    hyprpicker
    inputs.nix-software-center.packages.${pkgs.system}.nix-software-center
    kitty
    launchpad
    libdrm
    libnotify
    networkmanagerapplet
    pavucontrol
    playerctl
    polkit_gnome
    spotify
    swappy
    tesseract
    waybar
    wayland-protocols
    wl-clipboard
    wlogout
    wlroots
    xdg-utils
  ];
}
