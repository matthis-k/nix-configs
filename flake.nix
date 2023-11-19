{
  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:/danth/stylix";
    nix-software-center.url = "github:vlinkz/nix-software-center";
    hyprland.url = "github:hyprwm/Hyprland";
  };


  outputs = inputs@{ self, nixpkgs, home-manager, neovim-nightly-overlay, stylix, nix-software-center, hyprland, ... }:
    let
      software-center-overlay = final: prev: {
        nix-software-center = nix-software-center.packages.x86_64-linux.nix-software-center;
      };
      overlays = [
        neovim-nightly-overlay.overlay
        software-center-overlay
      ];
    in
    {
      nixosConfigurations.matthisk-laptop =
        let
          system = "x86_64-linux";
        in
        nixpkgs.lib.nixosSystem
          {
            inherit system;
            specialArgs = {
              inherit inputs;
              vars = (import ./vars.nix "laptop");
              inherit system;
            };
            modules = [
              ({ nixpkgs, ... }: { nixpkgs.overlays = overlays; })
              home-manager.nixosModules.home-manager
              stylix.nixosModules.stylix
              ./hosts/laptop/laptop.nix
              ./hosts/laptop/hardware-configuration.nix
              ./applications/neovim.nix
              ./applications/virtualbox.nix
              ./applications/firefox.nix
              ./applications/fish.nix
              ./desktops/hyprland
              ./displayManagers/gdm.nix
              ./base.nix
              ./themes/catppuccin.nix
            ];
          };
    };
}
