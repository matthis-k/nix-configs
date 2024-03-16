{
  pkgs,
  host,
  ...
}: {
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.gfxmodeEfi = "1920x1020";
  boot.loader.grub.gfxmodeBios = "1920x1020";
  boot.kernelParams =
    ["splash" "quiet" "udev.log_level=3"]
    ++ (
      if host == "desktop"
      then ["nvidia_drm.modeset=1"]
      else []
    );
  boot.initrd.systemd.enable = true;
  boot.plymouth = {
    enable = true;
    themePackages = [(pkgs.catppuccin-plymouth.override {variant = "mocha";})];
    theme = "catppuccin-mocha";
    font = "${pkgs.nerdfonts}/share/fonts/truetype/NerdFonts/HackNerdFont-Regular.ttf";
  };
}
