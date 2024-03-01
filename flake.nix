{
  description = "Best flake ever";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1&rev=918d8340afd652b011b937d29d5eea0be08467f5";

    Hyprspace.url = "github:KZDKM/Hyprspace";
    Hyprspace.inputs.hyprland.follows = "hyprland";

    # catppuccin.url = "github:catppuccin/nix";

    ags.url = "github:aylur/ags";
    ags.inputs.nixpkgs.follows = "nixpkgs";
    astal.url = "github:aylur/astal";
    astal.inputs.nixpkgs.follows = "nixpkgs";

    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    hyprland-plugins.inputs.hyprland.follows = "hyprland";

    rust-overlay.url = "github:oxalica/rust-overlay";

    spicetify.url = "github:Gerg-L/spicetify-nix";
    spicetify.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";

    firefox-nightly.url = "github:nix-community/flake-firefox-nightly";
    firefox-nightly.inputs.nixpkgs.follows = "nixpkgs-unstable";

    nixos-cli.url = "github:water-sucks/nixos";
    nixos-cli.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = [
      "x86_64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
    color = import ./color.nix;
  in {
    packages = forAllSystems (system:
      import ./pkgs {
        pkgs = nixpkgs.legacyPackages.${system};
        inherit color inputs;
      });
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    overlays = import ./overlays {inherit inputs color;};
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs color;
          host = "laptop";
        };
        modules = [
          inputs.home-manager.nixosModules.home-manager
          # inputs.catppuccin.nixosModules.catppuccin
          inputs.nixos-cli.nixosModules.nixos-cli
          ./nixos/configuration.nix
          ./nixos/hardware-configuration-laptop.nix
          {
            home-manager.extraSpecialArgs = {
              inherit inputs outputs color;
              host = "laptop";
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.matthisk = {pkgs, ...}: {
              imports = [
                ./home-manager/home.nix
              ];
            };
          }
        ];
      };
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs color;
          host = "desktop";
        };
        modules = [
          inputs.home-manager.nixosModules.home-manager
          # inputs.catppuccin.nixosModules.catppuccin
          inputs.nixos-cli.nixosModules.nixos-cli
          ./nixos/configuration.nix
          ./nixos/hardware-configuration-desktop.nix
          {
            home-manager.extraSpecialArgs = {
              inherit inputs outputs color;
              host = "desktop";
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.matthisk = {pkgs, ...}: {
              imports = [
                ./home-manager/home.nix
              ];
            };
          }
        ];
      };
    };

    homeConfigurations = {
      "matthisk@laptop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs color;
          host = "laptop";
        };
        modules = [
          ./home-manager/home.nix
          {
            nixpkgs = {
              overlays = [
                outputs.overlays.additions
                outputs.overlays.modifications
                outputs.overlays.unstable-packages

                inputs.nur.overlay
                inputs.rust-overlay.overlays.default
              ];
              config = {
                allowUnfree = true;
                allowUnfreePredicate = _: true;
                permittedInsecurePackages = [
                  "nix-2.16.2"
                  "electron-24.8.6"
                ];
              };
            };
          }
        ];
      };
      "matthisk@desktop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs color;
          host = "desktop";
        };
        modules = [
          ./home-manager/home.nix
          {
            nixpkgs = {
              overlays = [
                outputs.overlays.additions
                outputs.overlays.modifications
                outputs.overlays.unstable-packages

                inputs.nur.overlay
                inputs.rust-overlay.overlays.default
              ];
              config = {
                allowUnfree = true;
                allowUnfreePredicate = _: true;
                permittedInsecurePackages = [
                  "electron-24.8.6"
                ];
              };
            };
          }
        ];
      };
    };
  };
}
