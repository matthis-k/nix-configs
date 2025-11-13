{
  nixos =
    { inputs, ... }:
    {
      imports = [ (inputs.qs-flake.nixosModules.default { quickshell = inputs.quickshell; }) ];
      services.quickde.enable = true;
    };
}
