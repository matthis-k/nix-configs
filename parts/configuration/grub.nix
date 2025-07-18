{
  nixos =
    { pkgs, lib, ... }:
    {

      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.grub.enable = true;
      boot.loader.grub.device = "nodev";
      boot.loader.grub.useOSProber = true;
      boot.loader.grub.efiSupport = true;
      boot.loader.grub.gfxmodeEfi = "1920x1020";
      boot.loader.grub.gfxmodeBios = "1920x1020";
      boot.loader.grub.font = lib.mkForce "${pkgs.nerd-fonts.hack}/share/fonts/truetype/NerdFonts/Hack/HackNerdFontMono-Regular.ttf";

      boot.plymouth.enable = true;
      boot.plymouth.font = lib.mkForce "${pkgs.nerd-fonts.hack}/share/fonts/truetype/NerdFonts/Hack/HackNerdFontMono-Regular.ttf";

      boot.kernelParams = [
        "splash"
        "quiet"
        "udev.log_level=3"
      ];
      boot.initrd.systemd.enable = true;

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
    };
}
