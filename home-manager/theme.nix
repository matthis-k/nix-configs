{
  pkgs,
  config,
  ...
}: {
  home.pointerCursor = {
    gtk.enable = true;
    name = "Catppuccin-Mocha-Blue-Cursors";
    package = pkgs.catppuccin-cursors.mochaBlue;
    size = 24;
  };
  gtk.enable = true;
  gtk.theme = {
    name = "Catppuccin-Mocha-Standard-Blue-Dark";
    package = pkgs.catppuccin-gtk.override {
      variant = "mocha";
      accents = ["blue"];
      tweaks = ["normal"];
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

  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  qt.enable = true;
  qt.platformTheme.name = "qtct";
  qt.style.name = "kvantum";

  home.packages = with pkgs; [
    qt6Packages.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugin-kvantum
    (catppuccin-kvantum.override {
      accent = "Blue";
      variant = "Mocha";
    })
  ];

  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
    General.theme = "Catppuccin-Mocha-Blue";
  };
}
