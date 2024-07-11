{
  description = "Hyprland in catppuccin mocha";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-24.05;
    nixpkgs-unstable.url = github:nixos/nixpkgs/nixos-unstable;

    home-manager.url = github:nix-community/home-manager/release-24.05;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-software-center.url = github:vlinkz/nix-software-center;
    nix-software-center.inputs.nixpkgs.follows = "nixpkgs-unstable";

    waybar.url = github:Alexays/Waybar;
    waybar.inputs.nixpkgs.follows = "nixpkgs-unstable";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    Hyprspace.url = "github:KZDKM/Hyprspace";
    Hyprspace.inputs.hyprland.follows = "hyprland";

    ags.url = "github:Aylur/ags";

    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    hyprland-plugins.inputs.hyprland.follows = "hyprland";

    rust-overlay.url = github:oxalica/rust-overlay;

    spicetify.url = github:the-argus/spicetify-nix;

    nur.url = github:nix-community/NUR;
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
        inherit color;
      });
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    overlays = import ./overlays {inherit inputs color;};
    nixosModules = import ./modules/nixos color;
    homeManagerModules = import ./modules/home-manager color;
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs color;
          host = "laptop";
        };
        modules = [
          inputs.home-manager.nixosModules.home-manager
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
        ];
      };
    };
  };
}
