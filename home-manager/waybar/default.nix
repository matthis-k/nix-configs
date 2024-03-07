{
  pkgs,
  color,
  inputs,
  host,
  ...
}: {
  programs.waybar.settings = let
    p = color.palette;
    mainSettings = {
      layer = "top";
      position = "top";
      modules-left = ["hyprland/workspaces" "wlr/taskbar" "hyprland/window"];
      modules-center = ["clock"];
      modules-right = ["pulseaudio" "backlight" "battery" "tray" "power-profiles-daemon" "custom/notification"];
      "hyprland/window" = {
        format = "{initialClass}";
        seperate-outputs = true;
      };
      "hyprland/workspaces" = {
        format = "{name}";
        all-outputs = true;
        show-special = true;
        persistent-workspaces =
          if host == "laptop"
          then {
            "1" = "eDP-1";
            "2" = "eDP-1";
            "3" = "eDP-1";
            "4" = "eDP-1";
            "5" = "eDP-1";
          }
          else if host == "desktop"
          then {
            "1" = "HMDI-A-1";
            "2" = "HMDI-A-1";
            "3" = "HMDI-A-1";
            "4" = "HMDI-A-1";
            "5" = "HMDI-A-1";
            "6" = "DP-1";
            "7" = "DP-1";
            "8" = "DP-1";
            "9" = "DP-1";
            "10" = "DP-1";
          }
          else {};
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
        format = "{icon} {percent}%";
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

      power-profiles-daemon = {
        format = "{icon}";
        tooltip-format = "Power profile: {profile}\nDriver: {driver}";
        tooltip = true;
        format-icons = {
          default = "󰓅";
          performance = "󰓅";
          balanced = "󰾅";
          power-saver = "󰾆";
        };
      };

      "custom/notification" = {
        tooltip = false;
        format = "{icon}";
        format-icons = {
          notification = "<span foreground='${p.red}'>󱅫</span>";
          none = "<span foreground='${p.txt}'>󰂚</span>";
          dnd-notification = "<span foreground='${p.red}'>󰂛</span>";
          dnd-none = "<span foreground='${p.subtext0}'>󰂛</span>";
          inhibited-notification = "<span foreground='${p.red}'>󱅫</span>";
          inhibited-none = "<span foreground='${p.txt}'>󰂚</span>";
          dnd-inhibited-notification = "<span foreground='${p.red}'>󰂛</span>";
          dnd-inhibited-none = "<span foreground='${p.subtext0}'>󰂛</span>";
        };
        return-type = "json";
        exec = "${pkgs.swaynotificationcenter}/bin/swaync-client -swb";
        on-click-release = "${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
        on-click-right = "${pkgs.swaynotificationcenter}/bin/swaync-client -d -sw";
        on-click-middle = "${pkgs.swaynotificationcenter}/bin/swaync-client -C";
        escape = true;
      };
    };
  in
    if host == "laptop"
    then [
      (mainSettings // {output = "eDP-1";})
    ]
    else if host == "desktop"
    then [
      (mainSettings // {output = "HDMI-A-1";})
      (mainSettings // {output = "DP-1";})
    ]
    else [
      mainSettings
    ];
  programs.waybar.style = color.files pkgs ./style.css;
}
