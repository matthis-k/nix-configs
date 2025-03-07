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
        ags.ags
        ags.apps
        ags.auth
        ags.battery
        ags.bluetooth
        ags.cava
        ags.docs
        ags.gjs
        ags.greet
        ags.hyprland
        ags.io
        ags.mpris
        ags.network
        ags.notifd
        ags.powerprofiles
        ags.river
        ags.tray
        ags.wireplumber
        gjs

        grimblast
        hyprpolkitagent
        hyprshell
        satty
        wl-clipboard
      ];
    };
}
