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
  };

  config = mkIf config.hyprland.enable {
    waybar.enable = true;
    wlsunset.enable = true;
    dunst.enable = true;
    kanshi.enable = true;
    kanshi.systemdTarget = "hyprland-session.target";
    kanshi.exec = [
      "$HOME/.scripts/wallpaper"
    ];
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
    ];
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      settings = {
        "$terminal" = config.hyprland.terminal;
	"$menu" = "wofi " + config.hyprland.menuOptions;
	"$mainMod" = config.hyprland.mainMod;
        exec-once = [
          "firefox"
	  "$HOME/.scripts/wallpaper"
	  "hyprctl setcursor ${config.gtk.cursorTheme.name} ${toString config.gtk.cursorTheme.size}"
	  "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1"
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
	    special = true;
	  };
	  drop_shadow = true;
	  shadow_range = 4;
	  shadow_render_power = 3;
	  "col.shadow" = "rgba(1a1a1aee)";
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
	  no_gaps_when_only = 1;
	};
	master = {
	  new_is_master = true;
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
	};
	windowrulev2 = [
	];
	blurls = [
	  "notifications"
	  "waybar"
	  "wofi"
	];
	env = [
	  "QT_QPA_PLATFORMTHEME, qt6ct"
	  "XCURSOR_THEME, ${config.gtk.cursorTheme.name}"
	  "XCURSOR_SIZE, ${toString config.gtk.cursorTheme.size}"
	];
	bind = [
          "$mainMod, RETURN, exec, $terminal"
	  "$mainMod SHIFT, Q, killactive"
	  "$mainMod SHIFT, X, exit"
	  "$mainMod, V, togglesplit"
	  "$mainMod, D, exec, $menu"
	  "$mainMod, F, fullscreen, 1"
	  "$mainMod SHIFT, F, fullscreen, 0"
	  "$mainMod, SPACE, togglefloating"
	  "$mainMod SHIFT, E, movecurrentworkspacetomonitor, +1"

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
	  
	  "$mainMod, S, togglespecialworkspace, magic"
	  "$mainMod SHIFT, S, movetoworkspace, special:magic"

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
