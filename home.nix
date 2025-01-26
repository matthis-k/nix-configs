{ self, inputs, ... }:
{
  programs.home-manager.enable = true;
  imports = self.lib.importing.recursivePaths ./home ++ [
  ];
  home = {
    username = "matthisk";
    homeDirectory = "/home/matthisk";
  };
  systemd.user.startServices = "sd-switch";
  home.stateVersion = "24.11";
}
