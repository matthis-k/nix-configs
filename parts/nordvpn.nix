{
  nixos =
    { pkgs, inputs, ... }:
    {
      imports = [
        inputs.nordvpn-flake.nixosModules.default
      ];
      services.nordvpn = {
        enable = true;
        users = [ "matthisk" ];
      };
    };
}
