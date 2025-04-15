{
  nixos =
    {
      config,
      modulesPath,
      hostMachine,
      lib,
      ...
    }:
    {
      options = {
        hostMachine = lib.mkOption {
          type = lib.types.str;
          default = "laptop";
          description = "The name of the host machine.";
        };
      };
      config = {
        hostMachine = hostMachine;
      };

      imports = [
        ./${hostMachine}.nix
      ];
    };
}
