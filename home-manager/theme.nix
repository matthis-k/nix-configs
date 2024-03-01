{pkgs, ...}: {
  gtk.enable = true;
  gtk.theme = {
    name = "Catppuccin";
    package = pkgs.catppuccin-gtk.override {
      variant = "mocha";
      accents = ["blue"];
      tweaks = [];
    };
  };
  gtk.iconTheme = {
    package = pkgs.catppuccin-papirus-folders;
    name = "Papirus";
  };
  gtk.cursorTheme = {
    name = "Catppuccin-Mocha-Blue-Cursors";
    package = pkgs.catppuccin-cursors.mochaBlue;
    size = 24;
  };
  gtk.font = {
    name = "Hack Nerd Font Mono";
    package = pkgs.nerdfonts.override {
      fonts = [
        "FiraCode"
        "Hack"
      ];
    };
  };
}
