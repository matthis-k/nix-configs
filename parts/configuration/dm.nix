{
  nixos =
    { ... }:
    {
      services.displayManager.sddm.enable = true;
      services.displayManager.sddm.wayland.enable = true;
      services.displayManager.autoLogin.enable = true;
      services.displayManager.autoLogin.user = "matthisk";
      services.displayManager.defaultSession = "hyprland-uwsm";

      services.desktopManager.plasma6.enable = true;
    };
}
