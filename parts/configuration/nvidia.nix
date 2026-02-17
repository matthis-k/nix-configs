{
  nixos =
    { config, lib, ... }:
    {
      boot = lib.mkIf (config.hostMachine == "desktop") {
        kernelParams = [ "nvidia-drm.modeset=1" ];
        initrd.kernelModules = [
          "nvidia"
          "nvidia_modeset"
          "nvidia_uvm"
          "nvidia_drm"
        ];
      };

      hardware.graphics = lib.mkIf (config.hostMachine == "desktop") {
        package = config.hardware.nvidia.package;
        enable32Bit = true;
        package32 = config.hardware.nvidia.package.lib32;
      };

      hardware.nvidia = lib.mkIf (config.hostMachine == "desktop") {
        modesetting.enable = true;
        powerManagement.enable = true;
        open = true;
        nvidiaSettings = true;
      };

      services.xserver.videoDrivers = lib.mkIf (config.hostMachine == "desktop") [ "nvidia" ];
    };
}
