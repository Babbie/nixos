{ lib, config, pkgs, ... }:

with lib; {
  options = {
    hyprland.enable = mkEnableOption "Enable hyprland";
    hyprland.terminal = mkOption {
      default = "kitty";
      description = "Default terminal";
    };
    hyprland.menuOptions = mkOption {
      default = "--show drun";
      description = "Default application menu options";
    };
    hyprland.tearing = mkOption {
      default = false;
      description = "Whether to allow tearing or not";
    };
    hyprland.mainMod = mkOption {
      default = "SUPER";
      description = "The modifier key used for most operations";
    };
    hyprland.exec-once = mkOption {
      default = [];
      description = "Commands to run on startup";
    };
    hyprland.env = mkOption {
      default = [];
      description = "Env values to pass to hyprland";
    };
  };

  config = mkIf config.hyprland.enable {
    waybar.enable = true;
    ags.enable = true;
    #wlsunset.enable = true;
    dunst.enable = true;
    kanshi.enable = true;
    kanshi.systemdTarget = "hyprland-session.target";
    kanshi.exec = [
      "${config.home.homeDirectory}/.scripts/wallpaper"
    ];
    hyprlock.enable = true;
    hypridle.enable = true;
    gnome-keyring.enable = true;
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-hyprland xdg-desktop-portal-gtk ];
      config.hyprland.default = [ "hyprland" "gtk" ];
    };
    home.packages = with pkgs; [ 
      wofi
      swaybg
      xdg-utils
      wl-clipboard
      grimblast
      wdisplays
      playerctl
    ];
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      systemd.variables = [
        "DISPLAY"
          "HYPRLAND_INSTANCE_SIGNATURE"
          "WAYLAND_DISPLAY"
          "XDG_CURRENT_DESKTOP"
          "PATH"
          "DOTNET_ROOT"
      ];
      settings = {
        "$terminal" = config.hyprland.terminal;
        "$menu" = "wofi " + config.hyprland.menuOptions;
        "$mainMod" = config.hyprland.mainMod;
        exec-once = config.hyprland.exec-once ++ [
          "firefox"
            "${config.home.homeDirectory}/.scripts/wallpaper"
            "hyprctl setcursor ${config.gtk.cursorTheme.name} ${toString config.gtk.cursorTheme.size}"
            "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
            "hypridle"
        ];
        input = {
          kb_layout = "us";
          follow_mouse = 1;
          touchpad = {
            natural_scroll = true;
            tap-and-drag = true;
            drag_lock = true;
          };
        };
        cursor.no_hardware_cursors = true;
        general = {
          gaps_in = 5;
          gaps_out = 20;
          border_size = 2;
          "col.active_border" = "rgba(${config.colorScheme.palette.base0B}ff)";
          "col.inactive_border" = "rgba(${config.colorScheme.palette.base04}7f)";
          layout = "dwindle";
          allow_tearing = config.hyprland.tearing;
        };
        decoration = {
          rounding = 10;
          active_opacity = 1.0;
          inactive_opacity = 0.9;
          fullscreen_opacity = 1.0;
          blur = {
            enabled = true;
            size = 3;
            passes = 2;
            noise = 0;
            contrast = 0.9;
            brightness = 0.8;
            vibrancy = 0.2;
            vibrancy_darkness = 0;
            special = true;
          };
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
          };
        };
        animations = {
          enabled = true;
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
              "windowsOut, 1, 7, default, popin 80%"
              "border, 1, 10, default"
              "borderangle, 1, 8, default"
              "fade, 1, 7, default"
              "workspaces, 1, 6, default"
          ];
        };
        dwindle = {
          preserve_split = true;
        };
        gestures = {
          workspace_swipe = true;
        };
        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          background_color = "0x0";
          enable_swallow = true;
          swallow_regex = "kitty";
          swallow_exception_regex = "wev";
        };
        workspace = [
          # smart gaps
          "w[tv1], gapsout:0, gapsin:0"
          "f[1], gapsout:0, gapsin:0"
        ];
        windowrulev2 = [
          # smart gaps
          "bordersize 0, floating:0, onworkspace:w[tv1]"
          "rounding 0, floating:0, onworkspace:w[tv1]"
          "bordersize 0, floating:0, onworkspace:f[1]"
          "rounding 0, floating:0, onworkspace:f[1]"

          # opacity exception
          "opacity 1.0 override,title:(- YouTube)"
          "opacity 1.0 override,title:(KPN TV)"

          # prevent screen turn off
          "idleinhibit focus,title:(- YouTube)"
          "idleinhibit focus,title:(KPN TV)"
          "idleinhibit fullscreen,fullscreen:1"
        ];
        blurls = [
          "notifications"
            "waybar"
            "wofi"
            "agsbar"
        ];
        env = config.hyprland.env ++ [
          "QT_QPA_PLATFORMTHEME, qt6ct"
            "XCURSOR_THEME, ${config.gtk.cursorTheme.name}"
            "XCURSOR_SIZE, ${toString config.gtk.cursorTheme.size}"
            "NIXOS_OZONE_WL, 1"
            "SLURP_ARGS, '-b #${config.colorScheme.palette.base02}af -c #${config.colorScheme.palette.base0A} -B #${config.colorScheme.palette.base02}af'"
        ];
        bind = [
          ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
            ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
            ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
            ", XF86AudioLowerVolume, exec, ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%"
            ", XF86AudioRaiseVolume, exec, ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%"
            "$mainMod, RETURN, exec, $terminal"
            "$mainMod SHIFT, Q, killactive"
            "$mainMod SHIFT, X, exit"
            "$mainMod, V, togglesplit"
            "$mainMod, D, exec, $menu"
            "$mainMod, F, fullscreen, 1"
            "$mainMod SHIFT, F, fullscreen, 0"
            "$mainMod, SPACE, togglefloating"
            "$mainMod SHIFT, E, movecurrentworkspacetomonitor, +1"
            "$mainMod, L, exec, hyprlock"

            "$mainMod, left, movefocus, l"
            "$mainMod, right, movefocus, r"
            "$mainMod, up, movefocus, u"
            "$mainMod, down, movefocus, d"

            "$mainMod SHIFT, left, movewindow, l"
            "$mainMod SHIFT, right, movewindow, r"
            "$mainMod SHIFT, up, movewindow, u"
            "$mainMod SHIFT, down, movewindow, d"

            "$mainMod, 1, workspace, 1"
            "$mainMod, 2, workspace, 2"
            "$mainMod, 3, workspace, 3"
            "$mainMod, 4, workspace, 4"
            "$mainMod, 5, workspace, 5"
            "$mainMod, 6, workspace, 6"
            "$mainMod, 7, workspace, 7"
            "$mainMod, 8, workspace, 8"
            "$mainMod, 9, workspace, 9"
            "$mainMod, 0, workspace, 0"

            "$mainMod SHIFT, 1, movetoworkspace, 1"
            "$mainMod SHIFT, 2, movetoworkspace, 2"
            "$mainMod SHIFT, 3, movetoworkspace, 3"
            "$mainMod SHIFT, 4, movetoworkspace, 4"
            "$mainMod SHIFT, 5, movetoworkspace, 5"
            "$mainMod SHIFT, 6, movetoworkspace, 6"
            "$mainMod SHIFT, 7, movetoworkspace, 7"
            "$mainMod SHIFT, 8, movetoworkspace, 8"
            "$mainMod SHIFT, 9, movetoworkspace, 9"
            "$mainMod SHIFT, 0, movetoworkspace, 0"

            "$mainMod, W, togglespecialworkspace, magic"
            "$mainMod SHIFT, W, movetoworkspace, special:magic"

            "$mainMod, S, exec, grimblast --notify copy active"
            "$mainMod SHIFT, S, exec, grimblast --notify copy area"
            "$mainMod ALT, S, exec, grimblast --notify save active ~/Pictures/Screenshots/$(date +%FT%T).png"
            "$mainMod SHIFT ALT, S, exec, grimblast --notify save area ~/Pictures/Screenshots/$(date +%FT%T).png"

            "$mainMod, mouse_down, workspace, e+1"
            "$mainMod, mouse_up, workspace, e-1"
            ];
        bindm = [
          "$mainMod, mouse:272, movewindow"
            "$mainMod, mouse:273, resizewindow"
        ];
      };
    };
  };
}
