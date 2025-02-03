{
  nixos =
    { inputs, ... }:
    {
      imports = [
        inputs.catppuccin.nixosModules.catppuccin
      ];
      catppuccin = {
        enable = true;
        accent = "blue";
        flavor = "mocha";
        cache.enable = true;
        sddm.font = "Hack Nerd Font Mono";
      };
    };
  homeManager =
    {
      catppuccin,
      nixosConfig,
      pkgs,
      ...
    }:
    {
      qt.enable = true;
      qt.style.name = "kvantum";
      qt.platformTheme.name = "kvantum";

      gtk.enable = true;
      imports = [
        catppuccin.homeManagerModules.catppuccin
      ];
      catppuccin = {
        enable = nixosConfig.catppuccin.enable;
        accent = nixosConfig.catppuccin.accent;
        flavor = nixosConfig.catppuccin.flavor;
        gtk.icon = {
          enable = nixosConfig.catppuccin.enable;
          accent = nixosConfig.catppuccin.accent;
          flavor = nixosConfig.catppuccin.flavor;
        };
        cursors.enable = true;
        cursors.accent = nixosConfig.catppuccin.accent;
      };
    };
}
