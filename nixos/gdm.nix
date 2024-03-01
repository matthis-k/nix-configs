{pkgs, ...}: {
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  programs.hyprland.enable = true;
  services.displayManager.defaultSession = "hyprland";

  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;

  programs.dconf.profiles.gdm.databases = [
    {
      settings."org/gnome/desktop/peripherals/touchpad" = {
        tap-to-click = true;
      };
    }
  ];
}
