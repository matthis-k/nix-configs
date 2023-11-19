{ inputs, pkgs, vars, home-manager, system, ... }: {
  programs.hyprland.enable = true;
  programs.hyprland.package = inputs.hyprland.packages.${system}.hyprland;
  # TDOD: optiondepending on sys-name for desktop
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  security.polkit.enable = true;
  environment.systemPackages = with pkgs; [
    spotify
    nix-software-center
    discord

    hyprpaper
    # swaybg
    # swww
    xwaylandvideobridge
    blueberry
    brightnessctl
    dunst
    grimblast
    kitty
    networkmanagerapplet
    nwg-look
    polkit_gnome
    rofi-wayland
    rofimoji
    swaylock-effects
    waybar
    wayland-protocols
    wdisplays
    wl-clipboard
    wlogout
    wlroots
    xdg-utils
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "DroidSansMono"
        "FiraMono"
        "Go-Mono"
        "Hack"
        "Inconsolata"
        "Iosevka"
        "IosevkaTerm"
        "JetBrainsMono"
        "RobotoMono"
        "SourceCodePro"
        "Terminus"
      ];
    })
    font-awesome
  ];

  home-manager.users.${vars.username} = {
    programs.waybar.enable = true;
    programs.waybar.settings = (import ./waybar.nix).settings;
    # programs.waybar.style = (import ./waybar.nix).style;
    wayland.windowManager.hyprland.settings = (import ./hyprland.nix).settings;
  };
}
