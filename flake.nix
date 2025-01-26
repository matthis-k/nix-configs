{
  description = "Best flake ever";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland/v0.47.0";

    # stylix.url = "github:danth/stylix";
    base16.url = "github:SenchoPens/base16.nix";
    base16-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };

    nvim-flake = {
      url = "github:matthis-k/nvim-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      mylib = import ./lib;
      packages = nixpkgs.lib.genAttrs [ "x86_64-linux" ] (system: {
        nvim = inputs.nvim-flake.packages.${system}.nvim;
      });
    in
    {
      inherit packages;
      lib = mylib;
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs mylib;
          };
          modules = [
            inputs.hyprland.nixosModules.default
            inputs.home-manager.nixosModules.home-manager
            # inputs.stylix.nixosModules.stylix
            inputs.base16.nixosModule
            { scheme = "${inputs.base16-schemes}/base16/catppuccin-mocha.yaml"; }
            ./nixos/configuration.nix
            ./nixos/hardware-configuration.nix
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.matthisk = ./home.nix;
              home-manager.extraSpecialArgs = inputs;
            }
          ];
        };
      };
    };
}
