{
  nixos =
    {
      config,
      modulesPath,
      hostMachine,
      ...
    }:
    {
      imports = [
        ./${hostMachine}.nix
      ];
    };
}
