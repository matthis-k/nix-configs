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

  programs.rofi.enable = true;
  programs.rofi.package = pkgs.rofi-wayland;

  xdg.configFile."wallpaper.png".source = ./wallpaper.png;

  home.packages = with pkgs;
    [
      blueberry
      brightnessctl
      discord
      libsForQt5.qt5ct
      libsForQt5.qt5.qtwayland
      libsForQt5.qt5.qtwayland
      qt6.qtwayland
      grimblast
      hyprpaper
      hyprpicker
      kitty
      launchpad
      libdrm
      libnotify
      networkmanagerapplet
      pavucontrol
      playerctl
      polkit_gnome
      swappy
      tesseract
      wayland-protocols
      wl-clipboard
      wlogout
      wlroots
      xdg-utils
    ]
    ++ (
      if host == "desktop"
      then with pkgs; [libva]
      else []
    );
}
