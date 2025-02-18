{
  description = "Best flake ever";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland/v0.47.0";
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # stylix.url = "github:danth/stylix";
    catppuccin.url = "github:catppuccin/nix";

    base16.url = "github:SenchoPens/base16.nix";
    base16-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };

    nvim-flake = {
      url = "github:matthis-k/nvim-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags-flake = {
      url = "github:matthis-k/ags-flake";
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
      lib = import ./lib;
      packages = nixpkgs.lib.genAttrs [ "x86_64-linux" ] (system: {
        nvim = inputs.nvim-flake.packages.${system}.nvim;
      });
    in
    {
      inherit packages lib;
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          modules =
            let
              parts = lib.importing.recursivePaths ./parts |> builtins.map (path: import path);
              nixosParts = parts |> builtins.map (part: part.nixos or { });
              hmParts = parts |> builtins.map (part: part.homeManager or { });
            in
            nixosParts
            ++ [
              inputs.hyprland.nixosModules.default
              inputs.home-manager.nixosModules.home-manager
              inputs.lix-module.nixosModules.default
              # inputs.stylix.nixosModules.stylix
              inputs.base16.nixosModule
              { scheme = "${inputs.base16-schemes}/base16/catppuccin-mocha.yaml"; }
              ./nixos/configuration.nix
              ./nixos/hardware-configuration.nix
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.backupFileExtension = "bak";
                home-manager.users.matthisk = {
                  programs.home-manager.enable = true;
                  imports = hmParts;
                  home = {
                    username = "matthisk";
                    homeDirectory = "/home/matthisk";
                  };
                  systemd.user.startServices = "sd-switch";
                  home.stateVersion = "24.11";
                };
                home-manager.extraSpecialArgs = inputs;
              }
            ];
        };
      };
    };
}
