{
  home-manager =
    { pkgs, ... }:
    {
    };

  nixos =
    { inputs, pkgs, ... }:
    {
      nixpkgs.overlays = [
        (final: prev: {
          zen-browser = {
            inherit (inputs.zen-flake.packages.${prev.stdenv.hostPlatform.system}) beta;
            inherit (inputs.zen-flake.packages.${prev.stdenv.hostPlatform.system}) twilight;
            inherit (inputs.zen-flake.packages.${prev.stdenv.hostPlatform.system}) twilight-official;
          };
        })
      ];
      environment.systemPackages = with pkgs; [ zen-browser.beta ];
    };
}
