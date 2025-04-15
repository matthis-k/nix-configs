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

      networking.hostName = "matthisk-laptop";
      networking.networkmanager.enable = true;
      systemd.services.NetworkManager-wait-online = {
        serviceConfig = {
          ExecStart = [
            ""
            "${pkgs.networkmanager}/bin/nm-online -q"
          ];
        };
      };
    };
}
