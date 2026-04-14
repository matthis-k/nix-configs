{
  pkgs,
  config,
  mylib,
  ...
}:
let
  l = mylib;
  p = l.colors.semanticPalette config.scheme;
in
{
  programs.hyprland.settings = {
    env =
      {
        laptop = [ ];
        desktop = [
          "GBM_BACKEND,nvidia-drm"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          "LIBVA_DRIVER_NAME,nvidia"
          "WLR_NO_HARDWARE_CURSORS,1"
          "__GL_GSYNC_ALLOWED"
          "__GL_VRR_ALLOWED,0"
          "ELECTRON_OZONE_PLATFORM_HINT,auto"
          "NVD_BACKEND,direct"
        ];
      }
      .${config.hostMachine};
    monitor =
      {
        laptop = [ "eDP-1,1920x1080,0x0,1" ];
        desktop = [
          "HDMI-A-1,1920x1080,0x0,1"
          "DP-1,1920x1080,1920x0,1"
        ];
      }
      .${config.hostMachine};
    exec-once = [
      "systemctl start --user hyprpolkitagent.service"
      "systemctl start --user quickde.service"
      "wl-paste --watch clipvault store"
    ];
    exec = [
      "${pkgs.uwsm}/bin/uwsm app -- ${pkgs.hyprland}/bin/hyprctl setcursor $HYPRCURSOR_THEME $HYPRCURSOR_SIZE"
      "systemctl restart --user quickde.service"
    ];

    general = {
      "col.active_border" = "rgba(${p.green}ff)";
      "col.inactive_border" = "rgba(${p.surface0}ff)";
      "col.nogroup_border" = "rgba(${p.green}ff)";
      "col.nogroup_border_active" = "rgba(${p.surface0}ff)";
      border_size = 2;
      gaps_in = 0;
      gaps_out = 0;
      gaps_workspaces = 0;
      layout = "scrolling";
      no_focus_fallback = false;
      resize_on_border = false;
      extend_border_grab_area = 15;
      hover_icon_on_border = true;
      allow_tearing = false;
      snap = {
        enabled = true;
        window_gap = 10;
        monitor_gap = 10;
        border_overlap = false;
      };
    };

    decoration = {
      rounding = 0;
      rounding_power = 2.0;
      active_opacity = 1.0;
      inactive_opacity = 1.0;
      fullscreen_opacity = 1.0;
      dim_inactive = false;
      dim_strength = 0.3;
      dim_special = 0.2;
      dim_around = 0.4;
      screen_shader = "";
      blur = {
        enabled = true;
        size = 8;
        passes = 1;
        ignore_opacity = false;
        new_optimizations = true;
        xray = false;
        noise = 0.0117;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
        special = false;
        popups = false;
        input_methods = false;
        input_methods_ignorealpha = 0.2;
      };
      shadow = {
        enabled = false;
        range = 4;
        render_power = 3;
        color = "rgba(${p.green}ff)";
        color_inactive = "rgba(${p.mantle}ff)";
        offset = "2, 2";
        scale = 1.0;
      };
    };
    animations = {
      enabled = true;
      workspace_wraparound = false;
    };

    bezier = [
      # "easeInSine,0.12, 0, 0.39, 0"
      # "easeOutSine,0.61, 1, 0.88, 1"
      # "easeInOutSine,0.37, 0, 0.63, 1"
      # "easeInQuad,0.11, 0, 0.5, 0"
      # "easeOutQuad,0.5, 1, 0.89, 1"
      # "easeInOutQuad,0.45, 0, 0.55, 1"
      # "easeInCubic,0.32, 0, 0.67, 0"
      # "easeOutCubic,0.33, 1, 0.68, 1"
      # "easeInOutCubic,0.65, 0, 0.35, 1"
      "easeInQuart,0.5, 0, 0.75, 0"
      "easeOutQuart,0.25, 1, 0.5, 1"
      "easeInOutQuart,0.76, 0, 0.24, 1"
      # "easeInQuint,0.64, 0, 0.78, 0"
      # "easeOutQuint,0.22, 1, 0.36, 1"
      # "easeInOutQuint,0.83, 0, 0.17, 1"
      # "easeInExpo,0.7, 0, 0.84, 0"
      # "easeOutExpo,0.16, 1, 0.3, 1"
      # "easeInOutExpo,0.87, 0, 0.13, 1"
      # "easeInCirc,0.55, 0, 1, 0.45"
      # "easeOutCirc,0, 0.55, 0.45, 1"
      # "easeInOutCirc,0.85, 0, 0.15, 1"
      # "easeInBack,0.36, 0, 0.66, -0.56"
      # "easeOutBack,0.34, 1.56, 0.64, 1"
      # "easeInOutBack,0.68, -0.6, 0.32, 1.6"
    ];
    animation = [
      "global,1,4,easeInOutQuart"
      "windowsOut,1,4,easeOutQuart,slide left"
      "windowsIn,1,4,easeOutQuart,slide right"
      "windowsMove,1,4,easeInOutQuart"
      "layers,0"
      "fade,0"
      "border,0"
      "borderangle,1,4,easeInOutQuart,once"
      "workspaces,1,4,easeInOutQuart,slidevert"
      "specialWorkspace,1,4,easeInOutQuart,fade"
      "zoomFactor,1,4,easeInOutQuart"
      "monitorAdded,1,4,easeOutQuart"
    ];

    input = {
      kb_model = "";
      kb_layout = "de";
      kb_variant = "";
      kb_options = "";
      kb_rules = "";
      kb_file = "";
      numlock_by_default = true;
      resolve_binds_by_sym = false;
      repeat_rate = 25;
      repeat_delay = 600;
      sensitivity = 0;
      accel_profile = "";
      force_no_accel = false;
      left_handed = false;
      scroll_method = "2fg";
      scroll_button = 0;
      scroll_button_lock = 0;
      natural_scroll = false;
      follow_mouse = 1;
      mouse_refocus = true;
      float_switch_override_focus = 1;
      special_fallthrough = false;
      off_window_axis_events = 1;
      emulate_discrete_scroll = 1;
      touchpad = {
        disable_while_typing = true;
        natural_scroll = true;
        scroll_factor = 1.0;
        middle_button_emulation = false;
        tap_button_map = "lrm";
        clickfinger_behavior = false;
        tap-to-click = true;
        drag_lock = false;
        tap-and-drag = true;
      };
      touchdevice = {
        enabled = true;
        transform = 0;
        output = "eDP-1";
      };
    };
    gestures = {
      workspace_swipe_distance = 300;
      workspace_swipe_touch = true;
      workspace_swipe_invert = true;
      workspace_swipe_touch_invert = true;
      workspace_swipe_min_speed_to_force = 30;
      workspace_swipe_cancel_ratio = 0.5;
      workspace_swipe_create_new = true;
      workspace_swipe_direction_lock = true;
      workspace_swipe_direction_lock_threshold = 10;
      workspace_swipe_forever = false;
      workspace_swipe_use_r = false;
      close_max_timeout = 1000;
    };

    group = {
      auto_group = true;
      insert_after_current = true;
      focus_removed_window = true;
      drag_into_group = 1;
      merge_groups_on_drag = true;
      merge_groups_on_groupbar = true;
      merge_floated_into_tiled_on_groupbar = false;
      group_on_movetoworkspace = false;
      "col.border_active" = "rgba(${p.green}ff)";
      "col.border_inactive" = "rgba(${p.surface0}ff)";
      "col.border_locked_active" = "rgba(${p.green}ff)";
      "col.border_locked_inactive" = "rgba(${p.surface0}ff)";
      groupbar = {
        enabled = true;
        font_family = "Sans";
        font_size = 11;
        gradients = true;
        height = 14;
        priority = 3;
        render_titles = true;
        blur = false;
        scrolling = false;
        text_color = "rgba(${p.text}ff)";
        "col.active" = "rgba(${p.green}ff)";
        "col.inactive" = "rgba(${p.surface0}ff)";
        "col.locked_active" = "rgba(${p.green}ff)";
        "col.locked_inactive" = "rgba(${p.surface0}ff)";
      };
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      "col.splash" = "rgba(ffffffff)";
      font_family = "Sans";
      splash_font_family = "Sans";
      force_default_wallpaper = false;
      vrr = 0;
      mouse_move_enables_dpms = true;
      key_press_enables_dpms = true;
      always_follow_on_dnd = true;
      layers_hog_keyboard_focus = true;
      animate_manual_resizes = false;
      animate_mouse_windowdragging = false;
      disable_autoreload = false;
      enable_swallow = false;
      swallow_regex = "";
      swallow_exception_regex = "";
      focus_on_activate = false;
      mouse_move_focuses_monitor = true;
      allow_session_lock_restore = false;
      background_color = "rgba(${p.base}ff)";
      close_special_on_empty = true;
      on_focus_under_fullscreen = 0;
      exit_window_retains_fullscreen = false;
      initial_workspace_tracking = 1;
      middle_click_paste = false;
      render_unfocused_fps = 15;
      disable_xdg_env_checks = false;
      lockdead_screen_delay = 1000;
    };

    binds = {
      pass_mouse_when_bound = false;
      scroll_event_delay = 300;
      workspace_back_and_forth = true;
      allow_workspace_cycles = false;
      workspace_center_on = 0;
      focus_preferred_method = 0;
      ignore_group_lock = false;
      movefocus_cycles_fullscreen = true;
      movefocus_cycles_groupfirst = false;
      disable_keybind_grabbing = false;
      window_direction_monitor_fallback = true;
      allow_pin_fullscreen = false;
    };

    xwayland = {
      enabled = true;
      use_nearest_neighbor = true;
      force_zero_scaling = false;
    };

    opengl = {
      nvidia_anti_flicker = true;
    };

    render = {
      direct_scanout = false;
      expand_undersized_textures = true;
      xp_mode = false;
      ctm_animation = 2;
      cm_enabled = true;
      send_content_type = true;
      cm_auto_hdr = 1;
      new_render_scheduling = true;
      non_shader_cm = 3;
      cm_sdr_eotf = 0;
    };

    cursor = {
      sync_gsettings_theme = true;
      no_hardware_cursors = false;
      no_break_fs_vrr = false;
      min_refresh_rate = 24;
      hotspot_padding = 1;
      inactive_timeout = 0;
      no_warps = false;
      persistent_warps = false;
      warp_on_change_workspace = 0;
      default_monitor =
        {
          laptop = "eDP-1";
          desktop = "HDMI-A-1";
        }
        .${config.hostMachine};
      zoom_factor = 1.0;
      zoom_rigid = false;
      zoom_detached_camera = true;
      enable_hyprcursor = true;
      hide_on_key_press = false;
      hide_on_touch = true;
      use_cpu_buffer = 2;
      warp_back_after_non_mouse_input = false;
    };

    quirks = {
      prefer_hdr = 0;
    };

    ecosystem = {
      no_update_news = true;
      no_donation_nag = true;
    };

    dwindle = {
      pseudotile = false;
      force_split = 0;
      preserve_split = false;
      smart_split = false;
      smart_resizing = true;
      permanent_direction_override = false;
      special_scale_factor = 1.0;
      split_width_multiplier = 1.0;
      use_active_for_splits = true;
      default_split_ratio = 1.0;
    };

    master = {
      allow_small_split = false;
      special_scale_factor = 1.0;
      mfact = 1.0;
      new_status = "slave";
      new_on_top = false;
      new_on_active = "none";
      orientation = "left";
      slave_count_for_center_master = 2;
      center_master_fallback = "left";
      smart_resizing = false;
      drop_at_cursor = true;
      always_keep_position = false;
    };

    scrolling = {
      fullscreen_on_one_column = true;
      column_width = 0.9;
      focus_fit_method = 1;
      follow_focus = true;
      follow_min_visible = 0.1;
      explicit_column_widths = "0.333, 0.5, 0.667, 1.0";
      direction = "right";
    };

    plugin = {
      "split-monitor-workspaces" = {
        count = 9;
        enable_persistent_workspaces = 0;
      };
    };

    bindl = [

      ", XF86AudioPlay, exec, ${pkgs.uwsm}/bin/uwsm app -- ${pkgs.playerctl}/bin/playerctl play-pause"
      ", XF86AudioNext, exec, ${pkgs.uwsm}/bin/uwsm app -- ${pkgs.playerctl}/bin/playerctl next"
      ", XF86AudioPrev, exec, ${pkgs.uwsm}/bin/uwsm app -- ${pkgs.playerctl}/bin/playerctl previous"
      ", XF86AudioStop, exec, ${pkgs.uwsm}/bin/uwsm app -- ${pkgs.playerctl}/bin/playerctl stop"
    ];

    bindle = [
      ", XF86MonBrightnessUp,     exec, ${pkgs.uwsm}/bin/uwsm app -- ${pkgs.brightnessctl}/bin/brightnessctl -c backlight set +5% -n 1"
      ", XF86MonBrightnessDown,   exec, ${pkgs.uwsm}/bin/uwsm app -- ${pkgs.brightnessctl}/bin/brightnessctl -c backlight set 5%- -n 1"
      ", XF86KbdBrightnessUp,     exec, ${pkgs.uwsm}/bin/uwsm app -- ${pkgs.brightnessctl}/bin/brightnessctl -c leds set +50%"
      ", XF86KbdBrightnessDown,   exec, ${pkgs.uwsm}/bin/uwsm app -- ${pkgs.brightnessctl}/bin/brightnessctl -c leds set 50%-"
      ", XF86AudioMute,           exec, ${pkgs.uwsm}/bin/uwsm app -- ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioRaiseVolume,    exec, ${pkgs.uwsm}/bin/uwsm app -- ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume,    exec, ${pkgs.uwsm}/bin/uwsm app -- ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ];

    bind = [
      "alt control, w, exec, ${pkgs.uwsm}/bin/uwsm app -- zen-beta" # TODO use the one from (hm module) programs.zen-browser.package somehow
      "super, a, exec, ${pkgs.quickde}/bin/quickde ipc call applauncher open"
      "super, b, exec, ${pkgs.quickde}/bin/quickde ipc call bar toggle"
      "super shift, 1, split-movetoworkspace, 1"
      "super shift, 2, split-movetoworkspace, 2"
      "super shift, 3, split-movetoworkspace, 3"
      "super shift, 4, split-movetoworkspace, 4"
      "super shift, 5, split-movetoworkspace, 5"
      "super shift, 6, split-movetoworkspace, 6"
      "super shift, 7, split-movetoworkspace, 7"
      "super shift, 8, split-movetoworkspace, 8"
      "super shift, 9, split-movetoworkspace, 9"
      "super shift, f, fullscreen, 1"
      "super shift, h, layoutmsg, swapcol l"
      "super shift, j, split-movetoworkspace, +1"
      "super shift, k, split-movetoworkspace, -1"
      "super shift, l, layoutmsg, swapcol r"
      "super control, h, focusmonitor, l"
      "super control, j, focusmonitor, d"
      "super control, k, focusmonitor, u"
      "super control, l, focusmonitor, r"
      "super shift, e, exec, ${pkgs.uwsm}/bin/uwsm app -- wl-paste | ${pkgs.satty}/bin/satty --copy-command ${pkgs.wl-clipboard}/bin/wl-copy --fullscreen -f -"
      "super, code:47, layoutmsg, colresize -0.05" # ö
      "super, code:48, layoutmsg, colresize +0.05" # ä
      "super, comma, layoutmsg, move -col"
      "super, period, layoutmsg, move +col"
      "super shift, p, exec, ${pkgs.uwsm}/bin/uwsm app -- ${pkgs.hyprpicker}/bin/hyprpicker"
      "super shift, r, exec, ${pkgs.uwsm}/bin/uwsm app -- ${pkgs.grimblast}/bin/grimblast save area - | ${pkgs.tesseract}/bin/tesseract stdin stdout -l eng --psm 1 | ${pkgs.wl-clipboard}/bin/wl-copy"
      "super shift, s, exec, ${pkgs.uwsm}/bin/uwsm app -- ${pkgs.grimblast}/bin/grimblast copy area"
      ", print, exec, ${pkgs.uwsm}/bin/uwsm app -- ${pkgs.grimblast}/bin/grimblast copy screen"
      "super, 1, split-workspace, 1"
      "super, 2, split-workspace, 2"
      "super, 3, split-workspace, 3"
      "super, 4, split-workspace, 4"
      "super, 5, split-workspace, 5"
      "super, 6, split-workspace, 6"
      "super, 7, split-workspace, 7"
      "super, 8, split-workspace, 8"
      "super, 9, split-workspace, 9"
      "super, f, fullscreen"
      "super, g, togglegroup"
      "super, h, layoutmsg, focus l"
      "super, j, split-workspace, +1"
      "super, k, split-workspace, -1"
      "super, l, layoutmsg, focus r"
      "super, m, fullscreen, 1"
      "super, q, killactive"
      "super, return, exec, ${pkgs.uwsm}/bin/uwsm app -- ${pkgs.kitty}/bin/kitty"
      "super, space, togglefloating"
      "super, p, pin"
      # "super, tab, overview:toggle"
    ];
    gesture = [
      "3, vertical, workspace"
      "3, left, dispatcher, layoutmsg, move +col"
      "3, right, dispatcher, layoutmsg, move -col"
    ];

    bindm = [
      "super, mouse:272, movewindow"
      "super, mouse:273, resizewindow"
    ];
    windowrule = [
      # only show border when 1 window in wokspace
      "match:float false, match:workspace w[tv1], border_size 0"
      "match:float false, match:workspace w[tv1], rounding 0"
      "match:float false, match:workspace f[1], border_size 0"
      "match:float false, match:workspace f[1], rounding 0"
    ];
    # no gaps when 1 window in wokspace
    workspace = [
      "w[tv1], gapsout:0, gapsin:0"
      "f[1], gapsout:0, gapsin:0"
    ];
  };
}
