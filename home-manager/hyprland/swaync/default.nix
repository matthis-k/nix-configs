{
  inputs,
  pkgs,
  color,
  ...
}: {
  home.packages = with pkgs; [
    swaynotificationcenter
    power-profiles-daemon
  ];

  xdg.configFile."swaync/style.css".source = color.files pkgs ./style.css;
  xdg.configFile."swaync/config.json".text =
    builtins.toJSON
    {
      control-center-margin-bottom = 0;
      control-center-margin-left = 0;
      control-center-margin-right = 0;
      control-center-margin-top = 0;
      layer = "top";
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
          state = "ignored";
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
        "backlight#KB" = {
          label = "";
          device = "dell::kbd_backlight";
          subsystem = "leds";
        };
        backlight = {
          device = "intel_backlight";
          label = "󰛨";
          min = 1;
        };
        buttons-grid = {
          actions = [
            {
              command = "${pkgs.networkmanager}/bin/nm-connection-editor";
              label = "";
            }
            {
              command = "${pkgs.blueberry}/bin/blueberry";
              label = "󰂯";
            }
            {
              command = "${pkgs.spotify}/bin/spotify";
              label = "󰓇";
            }
            {
              command = "${pkgs.firefox}/bin/firefox";
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
                command = "${pkgs.hyprlock}/bin/hyprlock";
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
                command = "${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance";
                label = "Performance";
              }
              {
                command = "${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced";
                label = "Balanced";
              }
              {
                command = "${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver";
                label = "Power-saver";
              }
            ];
            label = "󱐋";
            position = "left";
          };
          "menu#screenshot-buttons" = {
            actions = [
              {
                command = "${pkgs.swaynotificationcenter}/bin/swaync-client -cp && sleep 1 && ${pkgs.grimblast}/bin/grimblast copy screen";
                label = "Entire screen";
              }
              {
                command = "${pkgs.swaynotificationcenter}/bin/swaync-client -cp && sleep 1 && ${pkgs.grimblast}/bin/grimblast copy screen";
                label = "Select a region";
              }
            ];
            label = "󰹑";
            position = "left";
          };
        };
        mpris = {image-size = 32;};
        title = {
          button-text = "Clear";
          clear-all-button = true;
          text = "Notifications";
        };
        volume = {
          label = "";
          show-per-app = true;
          expand-button-label = "󰞖";
          collapse-button-label = "󰞕";
          empty-list-label = "No audio playing";
        };
      };
      widgets = ["label" "menubar" "buttons-grid" "backlight" "backlight#KB" "volume" "mpris" "title" "dnd" "notifications"];
    };
}
