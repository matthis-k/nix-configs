{
  pkgs,
  color,
  ...
}: {
  programs.waybar.settings = let
    p = color.palette;
  in {
    mainBar = {
      layer = "top";
      position = "top";
      modules-left = ["hyprland/workspaces" "wlr/taskbar" "hyprland/window"];
      modules-center = ["clock" "custom/notification"];
      modules-right = ["pulseaudio" "backlight" "battery" "tray"];
      "hyprland/window" = {
        format = "{initialClass}";
        seperate-outputs = false;
      };
      "hyprland/workspaces" = {
        format = "{name}";
        all-outputs = true;
        show-special = true;
        persistent-workspaces = {
          "1" = ["eDP-1"];
          "2" = ["eDP-1"];
          "3" = ["eDP-1"];
          "4" = ["eDP-1"];
          "5" = ["eDP-1"];
        };
      };

      "wlr/taskbar" = {
        format = "{icon}";
        icon-size = 14;
        sort-by = "id";
        tooltip-format = "{title}";
        on-click = "activate";
        on-click-middle = "close";
      };

      clock = {
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format = "{:%H:%M}";
      };

      pulseaudio = {
        reverse-scrolling = 1;
        format = "{icon} {volume}%";
        format-bluetooth = "{icon} {volume}%";
        format-bluetooth-muted = "󰝟{icon}";
        format-muted = "󰝟";
        format-source-muted = "{icon}󰍭 {volume}%";
        format-icons = {
          headphone = "󰋋";
          hands-free = "󰥰";
          headset = "󰋋";
          phone = "";
          portable = "";
          car = "󰄋";
          default = ["󰕿" "󰖀" "󰕾"];
        };
        on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
      };

      backlight = {
        reverse-scrolling = 1;
        device = "intel_backlight";
        format = "{percent}% {icon}";
        format-icons = ["" "" "" "" "" "" "" "" "" "" "" "" "" "" ""];
        on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl -c backlight set +5% -n 1";
        on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl -c backlight set 5%- -n 1";
      };

      battery = {
        bat = "BAT0";
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{capacity}% {icon}";
        format-icons = {
          plugged = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          discharging = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          full = "󰁹";
          charging = ["󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
        };
      };

      tray = {
        icon-size = 16;
        spacing = 4;
      };

      "custom/notification" = {
        tooltip = false;
        format = "{icon}";
        format-icons = {
          notification = "<span foreground='${p.peach}'><sup></sup></span>";
          none = "<span foreground='${p.peach}'><sup> </sup></span>";
          dnd-notification = "<span foreground='${p.peach}'><sup></sup></span>";
          dnd-none = "<span foreground='${p.peach}'><sup> </sup></span>";
          inhibited-notification = "<span foreground='${p.peach}'><sup></sup></span>";
          inhibited-none = "<span foreground='${p.peach}'><sup> </sup></span>";
          dnd-inhibited-notification = "<span foreground='${p.peach}'><sup></sup></span>";
          dnd-inhibited-none = "<span foreground='${p.peach}'><sup> </sup></span>";
        };
        return-type = "json";
        exec = "${pkgs.swaynotificationcenter}/bin/swaync-client -swb";
        on-click = "${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
        on-click-right = "${pkgs.swaynotificationcenter}/bin/swaync-client -d -sw";
        escape = true;
      };
    };
  };
  programs.waybar.style = color.files pkgs ./style.css;
}
