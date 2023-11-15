{ pkgs, vars, home-manager, ... }: {
  programs.hyprland.enable = true;
  # TDOD: optiondepending on sys-name for desktop
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  environment.systemPackages = with pkgs; [
    spotify
    nix-software-center
    discord
    firefox
    wezterm
    kitty
    rofi-wayland
    rofimoji
    waybar
    wlogout
    swaylock-effects
    wlroots
    wayland-protocols
    wl-clipboard
    xdg-utils
    dunst
    wdisplays
    grimblast
    nwg-look
    brightnessctl
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
  };
}
