{
  settings = {
    mainBar = {
      layer = "top";
      position = "top";
      modules-left = [ "hyprland/workspaces" "wlr/taskbar" "idle_inhibitor" ];
      modules-center = [ "clock" ];
      modules-right = [ "pulseaudio" "backlight" "battery" "tray" ];
      "hyprland/workspaces" = {
        format = "{icon}";
        all-outputs = true;
        show-special = true;
        format-icons = {
          active = "󰝥";
          empty = "󰝦";
          persistent = "󰝦";
          urgent = "󰗖";
          default = "";
        };
        persistent-workspaces = {
          "1" = [ "eDP-1" ];
          "2" = [ "eDP-1" ];
          "3" = [ "eDP-1" ];
          "4" = [ "eDP-1" ];
          "5" = [ "eDP-1" ];
        };
      };

      "wlr/taskbar" = {
        format = "{icon}";
        icon-size = 14;
        icon-theme = "Numix-Circle";
        tooltip-format = "{title}";
        on-click = "activate";
        on-click-middle = "close";
      };

      idle_inhibitor = {
        on_click = "./scripts/toggle_idle.sh";
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
        timeout = 30.5;
      };

      clock = {
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format = "{:%a; %d %b; %I:%M %p}";
      };

      "custom/notification" = {
        tooltip = false;
        format = "{icon}";
        format-icons = {
          notification = "󰂚<span foreground='orange'><sup></sup></span>";
          none = "󰂚<span><sup> </sup></span>";
          dnd-notification = "󰂛<span foreground='orange'><sup></sup></span>";
          dnd-none = "󰂛<span><sup> </sup></span>";
        };
        return-type = "json";
        exec-if = "which swaync-client";
        exec = "swaync-client -swb";
        on-click = "swaync-client -t -sw";
        on-click-right = "swaync-client -d -sw";
        escape = true;
      };

      pulseaudio = {
        reverse-scrolling = 1;
        format = "{volume}% {icon} {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = "󰝟 {icon} {format_source}";
        format-muted = "󰝟 {format_source}";
        format-source = "{volume}% 󰍬";
        format-source-muted = "{volume}% {icon} 󰍭";
        format-icons = {
          headphone = "󰋋";
          hands-free = "󰥰";
          headset = "󰋋";
          phone = "";
          portable = "";
          car = "󰄋";
          default = [ "󰕿" "󰖀" "󰕾" ];
        };
        on-click = "pavucontrol";
        min-length = 13;
      };

      backlight = {
        device = "intel_backlight";
        format = "{percent}% {icon}";
        format-icons = [ "󰃞" "󰃟" "󰃠" ];
        min-length = 7;
        on-scroll-up = "brightnessctl -c backlight set +1%";
        on-scroll-down = "brightnessctl -c backlight set 1%-";
      };

      battery = {
        bat = "BAT0";
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{capacity}% {icon}";
        format-icons = {
          plugged = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          discharging = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          full = "󰁹";
          charging = [ "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅" ];
        };
      };

      tray = {
        icon-size = 16;
        spacing = 0;
      };
    };
  };
}
