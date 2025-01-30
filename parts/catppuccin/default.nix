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
    { catppuccin, nixosConfig, ... }:
    {
      qt.style.name = "kvantum";
      gtk.enable = true;
      imports = [
        catppuccin.homeManagerModules.catppuccin
      ];
      catppuccin = {
        enable = nixosConfig.catppuccin.enable;
        accent = nixosConfig.catppuccin.accent;
        flavor = nixosConfig.catppuccin.flavor;
        gtk.enable = nixosConfig.catppuccin.enable;
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
