{
  description = "Best flake ever";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    qs-flake = {
      url = "github:matthis-k/qs-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    base16.url = "github:SenchoPens/base16.nix";
    base16-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };

    nvim-flake = {
      url = "github:matthis-k/nvim-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-flake = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nordvpn-flake = {
      url = "github:connerohnesorge/nordvpn-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      lib = import ./lib;

      build_config =
        hostMachine:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs hostMachine;
            mylib = lib;
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
                  home.stateVersion = "25.05";
                };
                home-manager.extraSpecialArgs = inputs // {
                  inherit hostMachine;
                };
              }
            ];
        };

    in
    let
      localPackages = nixpkgs.lib.genAttrs [ "x86_64-linux" ] (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          pkgFiles = lib.importing.recursivePaths ./pkgs;
          importedPkgs = builtins.map (path: {
            name = nixpkgs.lib.removeSuffix ".nix" (builtins.baseNameOf path);
            value = pkgs.callPackage path { };
          }) pkgFiles;
        in
        builtins.listToAttrs importedPkgs
      );
    in
    {
      inherit lib;
      packages = localPackages;
      overlays.default = final: prev: {
        locallyDefined = localPackages.${prev.stdenv.hostPlatform.system} or { };
      };
      nixosConfigurations = {
        laptop = build_config "laptop";
        desktop = build_config "desktop";
      };
    };
}
