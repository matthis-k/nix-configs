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

  home.packages = with pkgs; [
    blueberry
    brightnessctl
    discord
    grimblast
    hyprpaper
    hyprpicker
    kitty
    nix-software-center
    launchpad
    libdrm
    libnotify
    networkmanagerapplet
    pavucontrol
    playerctl
    polkit_gnome
    spotify
    swaybg
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
