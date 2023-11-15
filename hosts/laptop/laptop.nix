{pkgs, nixpkgs, config, ...}:
{
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
 #     efiSysMountPoint = "/boot/efi";
    };
  };
##  boot.loader.grub = {
#    enable = true;
#    useOSProber = true;
#    device = "/dev/sda";
#    efiSupport = true;
# };  
    boot.loader.systemd-boot.enable = true;
}
