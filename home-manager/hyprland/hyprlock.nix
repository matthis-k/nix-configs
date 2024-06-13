{
  inputs,
  pkgs,
  color,
  ...
}: let
  p = builtins.mapAttrs (name: col: (builtins.substring 1 (builtins.stringLength col) col)) color.palette;
in {
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = false;
        grace = 5;
        hide_cursor = true;
        no_fade_in = false;
      };
      backgrounds = [
        {
          monitor = "";
          path = "screenshot";
          color = "";
          blur_size = 5;
          blur_passes = 4;
          noise = 0.0117;
          contrast = 0.8917;
          vibrancy = 0.1686;
          vibrancy_darkness = 0.05;
        }
      ];
      input-fields = [
        {
          monitor = "";
          size = {
            width = 200;
            height = 50;
          };
          outline_thickness = 3;
          dots_size = 0.33;
          dots_spacing = 0.15;
          dots_center = true;
          outer_color = "rgb(${p.txt})";
          inner_color = "rgb(${p.base})";
          font_color = "rgb(${p.base})";
          fade_on_empty = true;
          placeholder_text = "<i>Input Password...</i>";
          hide_input = false;
          position = {
            x = 0;
            y = -20;
          };
          halign = "center";
          valign = "center";
        }
      ];
      labels = [
        {
          monitor = "";
          text = "<b>$TIME</b>";
          color = "rgb(${p.yellow})";
          font_size = 50;
          font_family = "Hack Nerd Font Mono";
          position = {
            x = 0;
            y = 130;
          };
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "Hi there, $USER";
          color = "rgb(${p.txt})";
          font_size = 25;
          font_family = "Hack Nerd Font Mono";
          position = {
            x = 0;
            y = 80;
          };
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
