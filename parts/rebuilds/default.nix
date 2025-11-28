{
  nixos =
    { config, pkgs, hostMachine, ... }:
    {
      environment.variables.NIX_HOST = hostMachine;
      environment.systemPackages = [
        pkgs.nrs
        pkgs.nrsu
      ];
    };
}