{
  nixos =
    { lib, pkgs, ... }:
    {
      nixpkgs.config.allowUnfreePredicate =
        pkg:
        builtins.elem (lib.getName pkg) [
          "steam"
          "steam-original"
          "steam-unwrapped"
          "steam-run"
        ];
      programs = {
        steam = {
          enable = true;
          remotePlay.openFirewall = false;
          dedicatedServer.openFirewall = true;
          localNetworkGameTransfers.openFirewall = true;
        };
      };
      hardware = {
        graphics = {
          enable = true;
          enable32Bit = true;
        };
      };
    };
}
