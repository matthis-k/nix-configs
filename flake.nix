{
  description = "Hyprland in catppuccin mocha";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-23.11;
    nixpkgs-unstable.url = github:nixos/nixpkgs/nixos-unstable;

    home-manager.url = github:nix-community/home-manager/release-23.11;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly-overlay.url = github:nix-community/neovim-nightly-overlay;

    nix-software-center.url = github:vlinkz/nix-software-center;
    nix-software-center.inputs.nixpkgs.follows = "nixpkgs-unstable";

    hyprland.url = github:hyprwm/Hyprland;

    hycov.url = github:DreamMaoMao/hycov;
    hycov.inputs.hyprland.follows = "hyprland";

    hyprlock.url = github:hyprwm/hyprlock;
    hyprlock.inputs.nixpkgs.follows = "nixpkgs";

    rust-overlay.url = github:oxalica/rust-overlay;

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
        specialArgs = {inherit inputs outputs color;};
        modules = [
          ./nixos/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      "matthisk@laptop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs color;};
        modules = [
          ./home-manager/home.nix
        ];
      };
    };
  };
}
