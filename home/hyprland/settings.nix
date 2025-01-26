{
  pkgs,
  nixosConfig,
  self,
  ...
}:
let
  p = self.lib.colors.semanticPalette nixosConfig.scheme;
in
{
  wayland.windowManager.hyprland.settings = {
    env = [ ];
    monitor = [ "eDP-1,1920x1080,0x0,1" ];
    exec = [
      # "${pkgs.ags}/bin/ags quit; ${pkgs.ags}/bin/ags run"
    ];

    general = {
      "col.active_border" = "rgba(${p.green}ff)";
      "col.inactive_border" = "rgba(${p.surface0}ff)";
      "col.nogroup_border" = "rgba(${p.green}ff)";
      "col.nogroup_border_active" = "rgba(${p.surface0}ff)";
      border_size = 2;
      no_border_on_floating = false;
      gaps_in = 0;
      gaps_out = 0;
      gaps_workspaces = 0;
      layout = "dwindle";
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
        ignore_window = true;
        color = "rgba(${p.green}ff)";
        color_inactive = "rgba(${p.mantle}ff)";
        offset = "2, 2";
        scale = 1.0;
      };
    };
    animations = {
      enabled = true;
      first_launch_animation = false;
      bezier = [
        "pace,0.46, 1, 0.29, 0.99"
        "overshot,0.13,0.99,0.29,1.1"
        "md3_decel, 0.05, 0.7, 0.1, 1"
      ];
      animation = [
        "windowsIn,1,6, md3_decel, slide"
        "windowsOut,1,6, md3_decel, slide"
        "windowsMove,1,6, md3_decel, slide"
        "fade,1,10, md3_decel"
        "workspaces,1,7, md3_decel, slide"
        "specialWorkspace,1,8, md3_decel, slide"
        "border,1,10, md3_decel"
      ];
    };

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
      workspace_swipe = true;
      workspace_swipe_fingers = 3;
      workspace_swipe_min_fingers = false;
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
      vfr = true;
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
      render_ahead_of_time = false;
      render_ahead_safezone = 1;
      allow_session_lock_restore = false;
      background_color = "rgba(${p.base}ff)";
      close_special_on_empty = true;
      new_window_takes_over_fullscreen = 0;
      exit_window_retains_fullscreen = false;
      initial_workspace_tracking = 2;
      middle_click_paste = false;
      render_unfocused_fps = 15;
      disable_xdg_env_checks = false;
      disable_hyprland_qtutils_check = false;
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
      force_introspection = 2;
    };

    render = {
      explicit_sync = 2;
      explicit_sync_kms = 2;
      direct_scanout = false;
      expand_undersized_textures = true;
      xp_mode = false;
      ctm_animation = 2;
      allow_early_buffer_release = true;
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
      default_monitor = "";
      zoom_factor = 1.0;
      zoom_rigid = false;
      enable_hyprcursor = true;
      hide_on_key_press = false;
      hide_on_touch = true;
      use_cpu_buffer = 2;
      warp_back_after_non_mouse_input = false;
    };

    ecosystem = {
      no_update_news = true;
      no_donation_nag = true;
    };

    experimental = {
      wide_color_gamut = false;
      hdr = false;
      xx_color_management_v4 = false;
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
      new_status="slave";
      new_on_top = false;
      new_on_active = "none";
      orientation = "left";
      inherit_fullscreen = true;
      center_master_slaves_on_right = false;
      smart_resizing = false;
      drop_at_cursor = true;
    };

    blurls = [ " waybar " ];

    bindl = [
      ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
      ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
      ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
      ", XF86AudioStop, exec, ${pkgs.playerctl}/bin/playerctl stop"
    ];

    bindle = [
      ", XF86MonBrightnessUp,     exec, ${pkgs.brightnessctl}/bin/brightnessctl -c backlight set +5% -n 1"
      ", XF86MonBrightnessDown,   exec, ${pkgs.brightnessctl}/bin/brightnessctl -c backlight set 5%- -n 1"
      ", XF86KbdBrightnessUp,     exec, ${pkgs.brightnessctl}/bin/brightnessctl -c leds set +50%"
      ", XF86KbdBrightnessDown,   exec, ${pkgs.brightnessctl}/bin/brightnessctl -c leds set 50%-"
      ", XF86AudioMute,           exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioRaiseVolume,    exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume,    exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ];

    bind = [
      "alt control, w, exec, ${pkgs.firefox}/bin/firefox"
      "super shift, 0, movetoworkspace, 10"
      "super shift, 1, movetoworkspace, 1"
      "super shift, 2, movetoworkspace, 2"
      "super shift, 3, movetoworkspace, 3"
      "super shift, 4, movetoworkspace, 4"
      "super shift, 5, movetoworkspace, 5"
      "super shift, 6, movetoworkspace, 6"
      "super shift, 7, movetoworkspace, 7"
      "super shift, 8, movetoworkspace, 8"
      "super shift, 9, movetoworkspace, 9"
      "super shift, f, fullscreen, 1"
      "super shift, h, movewindoworgroup, l"
      "super shift, e, exec, wl-paste | ${pkgs.swappy}/bin/swappy -f -"
      "super shift, j, movewindoworgroup, d"
      "super shift, k, movewindoworgroup, u"
      "super shift, l, movewindoworgroup, r"
      # "super shift, p, exec, ${pkgs.hyprpicker}/bin/hyprpicker"
      # "super shift, r, exec, ${pkgs.grimblast}/bin/grimblast save area - | ${pkgs.tesseract}/bin/tesseract stdin stdout -l eng --psm 1 | wl-copy"
      # "super shift, s, exec, ${pkgs.grimblast}/bin/grimblast copy area"
      "super, 0, workspace, 10"
      "super, 1, workspace, 1"
      "super, 2, workspace, 2"
      "super, 3, workspace, 3"
      "super, 4, workspace, 4"
      "super, 5, workspace, 5"
      "super, 6, workspace, 6"
      "super, 7, workspace, 7"
      "super, 8, workspace, 8"
      "super, 9, workspace, 9"
      "super, f, fullscreen"
      "super, g, togglegroup"
      "super, h, movefocus, l"
      "super, j, movefocus, d"
      "super, k, movefocus, u"
      "super, l, movefocus, r"
      "super, m, fullscreen, 1"
      "super, q, killactive"
      "super, return, exec, ${pkgs.kitty}/bin/kitty"
      "super, space, togglefloating"
      "super, x, exec, ${pkgs.wlogout}/bin/wlogout -p layer-shell"
      "super, p, pin"
      # "super, tab, overview:toggle"
    ];

    bindm = [
      "super, mouse:272, movewindow"
      "super, mouse:273, resizewindow"
    ];
    windowrule = [
      "float, pavucontrol"
      "float, nm-connection-editor"
      "float, blueberry.py"
      "float, xdg-desktop-portal"
      "float, xdg-desktop-portal-gnome"
    ];
  };
}
