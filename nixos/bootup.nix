{
  pkgs,
  host,
  lib,
  ...
}: {
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.gfxmodeEfi = "1920x1020";
  boot.loader.grub.gfxmodeBios = "1920x1020";
  boot.kernelParams = ["splash" "quiet" "udev.log_level=3"];
  hardware.nvidia.modesetting.enable = host == "desktop";
  boot.initrd.systemd.enable = true;
  boot.plymouth.enable = true;
  # boot.plymouth.catppuccin.enable = true;
  # boot.plymouth.catppuccin.flavor = "mocha";
  boot.loader.grub.font = lib.mkForce "${pkgs.nerdfonts}/share/fonts/truetype/NerdFonts/HackNerdFontMono-Regular.ttf";

  boot.loader.grub.extraEntries = ''
    menuentry "Firmware settings" --class efi {
        fwsetup
    }
    menuentry "Reboot" --class restart {
      reboot
    }
    menuentry "Shutdown" --class shutdown {
      halt
    }
  '';
}
