{
  nixos =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      environment.etc = lib.mapAttrs' (name: value: {
        name = "nix/path/${name}";
        value.source = value.flake;
      }) config.nix.registry;

      networking.hostName = "matthisk-${config.hostMachine}";
      networking.networkmanager.enable = true;
    };
}
