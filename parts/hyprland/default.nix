{
  nixos =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      environment.variables = {
        QT_QPA_PLATFORM = "wayland";
        SDL_VIDEODRIVER = "wayland";
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      };

      nix.settings.substituters = [
        "https://hyprland.cachix.org"
      ];
      nix.settings.trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];

      programs.hyprland = {
        enable = true;
        package = pkgs.hyprland;
        portalPackage = pkgs.xdg-desktop-portal-hyprland;
        withUWSM = true;
      };
      hardware.graphics = lib.mkIf (config.hostMachine == "desktop") {
        package = pkgs.unstable.mesa;
        enable32Bit = true;
        package32 = pkgs.unstable.pkgsi686Linux.mesa;
      };
      hardware.bluetooth.enable = true;
      services.power-profiles-daemon.enable = true;
      services.upower.enable = true;
      services.preload.enable = true;
      services.dbus.enable = true;
      services.xserver.enable = true;

      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        wireplumber.enable = true;
      };

      boot = lib.mkIf (config.hostMachine == "desktop") {
        kernelParams = [ "nvidia-drm.nodeset=1" ];
        initrd.kernelModules = [
          "nvidia"
          "nvidia_modeset"
          "nvidia_uvm"
          "nvidia_drm"
        ];
      };

      hardware.nvidia = lib.mkIf (config.hostMachine == "desktop") {
        modesetting.enable = true;
        powerManagement.enable = true;
        open = false;
        nvidiaSettings = true;
      };

      environment.systemPackages = lib.mkIf (config.hostMachine == "desktop") [
        config.boot.kernelPackages.nvidiaPackages.stable
      ];
      services.xserver.videoDrivers = lib.mkIf (config.hostMachine == "desktop") [ "nvidia" ];

      systemd.user.services.hyprpolkitagent = {
        enable = true;
        description = "HyprPolkitAgent Service";
        wantedBy = [ "default.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
        };
      };
    };
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
