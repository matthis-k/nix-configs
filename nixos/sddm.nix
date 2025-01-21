{pkgs, ...}: {
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "matthisk";
  programs.hyprland.enable = true;
  services.displayManager.defaultSession = "hyprland";

  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;

  services.displayManager.sddm.catppuccin.enable = true;
  services.displayManager.sddm.catppuccin.flavor = "mocha";
  services.displayManager.sddm.catppuccin.font = "Hack Nerd Font Mono";

  services.displayManager.sddm.package = pkgs.kdePackages.sddm;
}
