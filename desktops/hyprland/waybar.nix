{
  settings = {
    mainBar = {
      layer = "top";
      position = "top";
      modules-left = [ "group/left-whole" "custom/transition-c" ];
      modules-center = [ "custom/transition-x" "group/center-whole" "custom/transition-c" ];
      modules-right = [ "custom/transition-x" "group/right-whole" ];
      "group/left-whole" = {
        orientation = "inherit";
        modules = [ "group/left-a" "custom/transition-ab" "group/left-b" "custom/transition-bc" "group/left-c" ];
      };
      "group/left-a" = {
        modules = [ "hyprland/workspaces" ];
        orientation = "inherit";
      };
      "group/left-b" = {
        orientation = "inherit";
        modules = [ "wlr/taskbar" ];
      };
      "group/left-c" = {
        orientation = "inherit";
        modules = [ "hyprland/window" ];
      };

      "group/right-whole" = {
        orientation = "inherit";
        modules = [ "group/right-x" "custom/transition-xy" "group/right-y" "custom/transition-yz" "group/right-z" ];
      };
      "group/right-x" = {
        modules = [ "pulseaudio" ];
        orientation = "inherit";
      };
      "group/right-y" = {
        orientation = "inherit";
        modules = [ "backlight" ];
      };
      "group/right-z" = {
        orientation = "inherit";
        modules = [ "battery" "tray" ];
      };

      "group/center" = {
        orientation = "inherit";
        modules = [ "clock" ];
      };

      "group/center-whole" = {
        orientation = "inherit";
        modules = [
          "group/center-a"
          "custom/transition-xy"
          "group/center-b"
          "custom/transition-yz"
          "group/center"
          "custom/transition-ab"
          "group/center-y"
          "custom/transition-bc"
          "group/ransition-z"
        ];
      };
      "group/center-a" = {
        modules = [ ];
        orientation = "inherit";
      };
      "group/center-b" = {
        orientation = "inherit";
        modules = [ ];
      };
      "group/center-y" = {
        orientation = "inherit";
        modules = [ ];
      };
      "group/center-z" = {
        orientation = "inherit";
        modules = [ ];
      };

      "hyprland/window" = {
        format = "{title}";
        seperate-outputs = false;
      };
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
        format-icons = [ "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" ];
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

      "custom/transition-x" = {
        format = "";
        tooltip = false;
        exec = ''echo '{"class": "left-slant"}' '';
        return-type = "json";
        interval = "once";
      };
      "custom/transition-xy" = {
        format = "";
        tooltip = false;
        exec = ''echo '{"class": "left-slant"}' '';
        return-type = "json";
        interval = "once";
      };
      "custom/transition-yz" = {
        format = "";
        tooltip = false;
        exec = ''echo '{"class": "left-slant"}' '';
        return-type = "json";
        interval = "once";
      };
      "custom/transition-ab" = {
        format = "";
        tooltip = false;
        exec = ''echo '{"class": "right-slant"}' '';
        return-type = "json";
        interval = "once";
      };
      "custom/transition-bc" = {
        format = "";
        tooltip = false;
        exec = ''echo '{"class": "right-slant"}' '';
        return-type = "json";
        interval = "once";
      };
      "custom/transition-c" = {
        format = "";
        tooltip = false;
        exec = ''echo '{"class": "right-slant"}' '';
        return-type = "json";
        interval = "once";
      };
    };
  };
}
