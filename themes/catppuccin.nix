{ pkgs, stylix, home-manager, vars, ... }: {
  stylix.image = ./wallpaper.png;
  stylix.polarity = "dark";
  stylix.base16Scheme = {
    scheme = "Catppuccin Mocha";
    author = "https://github.com/catppuccin/catppuccin";
    base00 = "1e1e2e";
    base01 = "181825";
    base02 = "313244";
    base03 = "45475a";
    base04 = "585b70";
    base05 = "cdd6f4";
    base06 = "f5e0dc";
    base07 = "b4befe";
    base08 = "f38ba8";
    base09 = "fab387";
    base0A = "f9e2af";
    base0B = "a6e3a1";
    base0C = "94e2d5";
    base0D = "89b4fa";
    base0E = "cba6f7";
    base0F = "f2cdcd";
  };
  home-manager.users.${vars.username}.stylix.targets = {
    #solves https://github.com/danth/stylix/issues/180
    xfce.enable = false;
    fish.enable = false;
    waybar = {
      enable = false;
      enableRightBackColors = true;
      enableCenterBackColors = true;
      enableLeftBackColors = true;
    };
  };

  stylix.cursor = {
    package = pkgs.catppuccin-cursors.mochaBlue;
    name = "Catppuccin-Mocha-Blue-Cursors";
    size = 24;
  };

  stylix.fonts.monospace = {
    name = "Hack Nerd Font Mono";
    package = (pkgs.nerdfonts.override {
      fonts = [
        "FiraCode"
        "Hack"
      ];
    })
    ;
  };

  stylix.targets.plymouth.enable = false;
  boot.plymouth = {
    themePackages = [ (pkgs.catppuccin-plymouth.override { variant = "mocha"; }) ];
    theme = "catppuccin-mocha";
    font = "${pkgs.nerdfonts}/share/fonts/truetype/NerdFonts/HackNerdFont-Regular.ttf";
  };


}
