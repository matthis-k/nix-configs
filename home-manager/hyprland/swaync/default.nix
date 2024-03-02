{
  inputs,
  pkgs,
  color,
  ...
}: {
  home.packages = with pkgs; [
    swaynotificationcenter
  ];

  xdg.configFile."swaync/style.css".source = color.files pkgs ./style.css;
  xdg.configFile."swaync/config.json".text =
    builtins.toJSON
    {
      control-center-margin-bottom = 2;
      control-center-margin-left = 0;
      control-center-margin-right = 1;
      control-center-margin-top = 2;
      control-center-width = 380;
      fit-to-screen = true;
      hide-on-action = true;
      hide-on-clear = false;
      image-visibility = "when-available";
      keyboard-shortcuts = true;
      notification-body-image-height = 160;
      notification-body-image-width = 90;
      notification-icon-size = 48;
      notification-visibility = {
        mute-spotify = {
          app-name = "Spotify";
          state = "muted";
          urgency = "Low";
        };
      };
      notification-window-width = 366;
      positionX = "right";
      positionY = "top";
      script-fail-notify = true;
      scripts = {};
      timeout = 6;
      timeout-critical = 0;
      timeout-low = 4;
      transition-time = 100;
      widget-config = {
        backlight = {
          device = "intel_backlight";
          label = "󰥻";
          min = 1;
        };
        buttons-grid = {
          actions = [
            {
              command = "nm-connection-editor";
              label = "";
            }
            {
              command = "blueberry";
              label = "󰂯";
            }
            {
              command = "spotify";
              label = "󰓇";
            }
            {
              command = "firefox";
              label = "";
            }
          ];
        };
        dnd = {text = "Do Not Disturb";};
        label = {
          max-lines = 1;
          text = "Controll Center";
        };
        menubar = {
          "menu#power-buttons" = {
            actions = [
              {
                command = "systemctl reboot";
                label = "   Reboot";
              }
              {
                command = "hyprlock";
                label = "   Lock";
              }
              {
                command = "loginctl terminate-session \${XDG_SESSION_ID-}";
                label = "   Logout";
              }
              {
                command = "systemctl poweroff";
                label = "   Shut down";
              }
            ];
            label = "";
            position = "right";
          };
          "menu#powermode-buttons" = {
            actions = [
              {
                command = "powerprofilesctl set performance";
                label = "Performance";
              }
              {
                command = "powerprofilesctl set balanced";
                label = "Balanced";
              }
              {
                command = "powerprofilesctl set power-saver";
                label = "Power-saver";
              }
            ];
            label = "󱐋";
            position = "left";
          };
          "menu#screenshot-buttons" = {
            actions = [
              {
                command = "swaync-client -cp && sleep 1 && hyprshot -m output";
                label = "Entire screen";
              }
              {
                command = "swaync-client -cp && sleep 1 && hyprshot -m region";
                label = "Select a region";
              }
            ];
            label = "󰹑";
            position = "left";
          };
        };
        mpris = {image-size = 96;};
        title = {
          button-text = "󰐓";
          clear-all-button = true;
          text = "Notifications";
        };
        volume = {label = "";};
      };
      widgets = ["menubar" "label" "buttons-grid" "volume" "mpris" "title" "dnd" "notifications"];
    };
}
