{
  inputs,
  pkgs,
  color,
  ...
}: {
  imports = [
    ./hyprlock.nix
  ];
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = (import ./settings.nix) {inherit pkgs color;};
  wayland.windowManager.hyprland.package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  wayland.windowManager.hyprland.plugins = with pkgs; [
    inputs.hycov.packages.${pkgs.system}.hycov
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

  programs.hyprlock = {
    enable = true;

    general = {
      disable_loading_bar = false;
      grace = 5;
      hide_cursor = true;
      no_fade_in = false;
    };
    backgrounds = [
      {
        monitor = "";
        path = "screenshot";
        color = "";
        blur_size = 5;
        blur_passes = 4;
        noise = 0.0117;
        contrast = 0.8917;
        vibrancy = 0.1686;
        vibrancy_darkness = 0.05;
      }
    ];
    input-fields = [
      {
        monitor = "";
        size = {
          width = 200;
          height = 50;
        };
        outline_thickness = 3;
        dots_size = 0.33;
        dots_spacing = 0.15;
        dots_center = true;
        outer_color = "rgb(151515)";
        inner_color = "rgb(200,200,200)";
        font_color = "rgb(10,10,10)";
        fade_on_empty = true;
        placeholder_text = "<i>Input Password...</i>";
        hide_input = false;
        position = {
          x = 0;
          y = -20;
        };
        halign = "center";
        valign = "center";
      }
    ];
    labels = [
      {
        monitor = "";
        text = "<b>$TIME</b>";
        color = "rgb(200, 200, 200)";
        font_size = 50;
        font_family = "Hack Nerd Font Mono";
        position = {
          x = 0;
          y = 130;
        };
        halign = "center";
        valign = "center";
      }
      {
        monitor = "";
        text = "Hi there, $USER";
        color = "rgb(200, 200, 200)";
        font_size = 25;
        font_family = "Hack Nerd Font Mono";
        position = {
          x = 0;
          y = 80;
        };
        halign = "center";
        valign = "center";
      }
    ];
  };

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
    swaynotificationcenter
    tesseract
    waybar
    wayland-protocols
    wl-clipboard
    wlogout
    wlroots
    xdg-utils
  ];
}
