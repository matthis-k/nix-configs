{
  description = "Best flake ever";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland/v0.47.0";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    hyprpicker = {
      url = "github:hyprwm/hyprpicker";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    base16.url = "github:SenchoPens/base16.nix";
    base16-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };

    nvim-flake = {
      url = "github:matthis-k/nvim-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    ags-flake = {
      url = "github:matthis-k/ags-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-flake = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      lib = import ./lib;
      packages = nixpkgs.lib.genAttrs [ "x86_64-linux" ] (system: {
        nvim = inputs.nvim-flake.packages.${system}.nvim;
      });

      build_config =
        hostMachine:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs hostMachine;
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
              inputs.base16.nixosModule
              { scheme = "${inputs.base16-schemes}/base16/catppuccin-mocha.yaml"; }
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
                home-manager.extraSpecialArgs = inputs // {
                  inherit hostMachine;
                };
              }
            ];
        };

    in
    {
      inherit packages lib;
      nixosConfigurations = {
        laptop = build_config "laptop";
      };
    };
}
