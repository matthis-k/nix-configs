{
  nixos =
    { lib, inputs, ... }:
    {

      nixpkgs.config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
      nixpkgs.overlays =
        let
          unstable_overlay = final: prev: {
            unstable = import inputs.nixpkgs-unstable {
              system = prev.system;
            };
          };
        in
        [
          unstable_overlay
          inputs.nvim-flake.overlays.default
          inputs.nvim-flake.overlays.nvimdev
          inputs.ags-flake.overlays.default
          inputs.hyprland.overlays.default
          inputs.hyprpicker.overlays.default
        ];

      nix = {
        registry = (lib.mapAttrs (_: flake: { inherit flake; })) (
          (lib.filterAttrs (_: lib.isType "flake")) inputs
        );
        nixPath = [ "/etc/nix/path" ];
        gc.automatic = true;
        gc.dates = "weekly";
        gc.options = "--delete-older-than 14d";
        optimise.automatic = true;
        optimise.dates = [ "weekly" ];
        settings = {
          auto-optimise-store = true;
          experimental-features = [
            "nix-command"
            "flakes"
            "pipe-operators"
          ];
          substituters = [
            "https://nix-community.cachix.org"
            "https://cache.nixos.org/"
            "https://hyprland.cachix.org"
          ];
          trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          ];
        };
      };
    };
}
