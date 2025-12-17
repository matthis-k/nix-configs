{
  nixos =
    { hostMachine, ... }:
    {
      swapDevices = [
        {
          device = "/var/lib/swapfile";
          size =
            {
              laptop = 16 * 1024;
              desktop = 32 * 1024;
            }
            .${hostMachine};
        }
      ];
    };
}
