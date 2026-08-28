{ pkgs, ... }:
{
  imports = [
    ../../../util/palette.nix
  ];

  programs.noctalia = {
    enable = true;
    package = pkgs.symlinkJoin {
      name = "noctalia-wrapped";
      meta.mainProgram = "noctalia";
      paths = [ pkgs.noctalia ];
      buildInputs = [ pkgs.makeWrapper ];

      postBuild = ''
        wrapProgram $out/bin/noctalia \
          --prefix PATH : ${pkgs.lib.makeBinPath (
            with pkgs;
            [
              brightnessctl 
              # for lyrics
              python3
              playerctl
              # for mango layout controls
              jq
            ]
          )
        }
      '';
    };

    settings = {
      bar.default = {
        thickness = 32;
        margin_ends = 0;
        padding = 12;
        radius_top_left = 0;
        radius_top_right = 0;
        start = [ "layout" "workspaces" ];
        center = [ "active_window" ];
        end = [ "group:music" "tray" "volume" "group:stats" "privacy" "clock" ];
        capsule_group = [
          {
            enabled = true;
            fill = "surface_variant";
            id = "stats";
            members = [ "battery" "temp" "cpu" "ram" "disk-root" "disk-home" "nix-monitor" ];
            opacity = 1.0;
            padding = 6.0;
          }
          {
            enabled = true;
            fill = "surface_variant";
            id = "music";
            members = [ "lyrics" "audio_visualizer" ];
            opacity = 1.0;
            padding = 8.0;
          }
        ];
      };

      control_center = {
        hidden_tabs = [ "monitor" "notifications" ];
        sidebar_section = "none";
        calendar.show_events_card = false;
      };

      desktop_widgets.enabled = false;

      idle = {
        behavior_order = [ "lock" ];
        pre_action_fade_seconds = 5;
        behavior.lock = {
          enabled = true;
          action = "lock";
          timeout = 600.0;
        };
      };

      nightlight.enabled = true;

      notification = {
        filter_order = [ "no_history" ];
        filter.no_history = {
          enabled = true;
          match_content = ".*";
          show_toast = true;
          save_history = false;
          play_sound = true;
        };
      };

      osd.kinds.media = false;

      plugin_settings = {
        "avivbintangaringga/nix-monitor" = {
          clean_command = "run0 nix-collect-garbage -d";
          hide_optimize_button = true;
          update_command = "run0 nix flake update --flake ~/.config/nixos && run0 nixos-rebuild switch --flake ~/.config/nixos#";
        };
        "ezequiel/mango_layouts" = {
          panel_open_near_click = true;
          panel_placement = "attached";
          panel_position = "top_left";
          show_center_tile = false;
          show_deck = false;
          show_dwindle = false;
          show_grid = false;
          show_right_tile = false;
          show_tile = false;
          show_vertical_deck = false;
          show_vertical_grid = false;
          show_vertical_tile = false;
        };
        "h465855hgg/lyrics" = {
          char_width = 10;
          lyrics_sources = [ "lrclib" "netease" "splayer" "kugou" "qishui" "apple_music" "spotify" "musixmatch" ];
          show_romanization = true;
          translation_language = "en";
        };
      };

      plugins = {
        enabled = [
          "avivbintangaringga/nix-monitor"
          "h465855hgg/lyrics"
          "ezequiel/mango_layouts"
        ];
      };

      shell = {
        clipboard_enabled = false;
        password_style = "random";
        polkit_agent = true;
        show_location = false;

        launcher.providers = {
          emoji.global = true;
          windows.global = true;
        };

        panel = {
          launcher_placement = "attached";
          open_near_click_control_center = true;
          open_near_click_launcher = true;
          open_near_click_session = true;
        };

        screenshot.directory = "/tmp/screenshots";

        session = {
          show_shortcuts = false;
          actions = [
            {
              action = "lock";
              countdown_seconds = 0.0; 
              enabled = true;
              shortcut = "1";
              variant = "default";
            }
            {
              action = "reboot";
              countdown_seconds = 0.0;
              enabled = true;
              shortcut = "2";
              variant = "default";
            }
            {
              action = "shutdown";
              countdown_seconds = 0.0;
              enabled = true;
              shortcut = "3";
              variant = "default";
            }
          ];
        };
      };

      theme = {
        builtin = "Catppuccin";
        community_palette = "Catppuccin Macchiato Mauve";
        mode = "dark";
        source = "community";
        wallpaper_scheme = "m3-content";
      };

      wallpaper = {
        directory = "~/Pictures/Wallpapers";
        transition_on_startup = true;
        automation = {
          enabled = true;
          interval_seconds = 3600;
        };
      };

      widget = {
        active_window = {
          anchor = true;
          capsule = true;
          capsule_padding = 8;
          icon_size = 16;
          max_length = 500;
          min_length = 0;
          title_scroll = "on_hover";
        };

        audio_visualizer.mirrored = false;
        battery.hide_when_full = true;
        cpu.show_value = false;

        disk-home = {
          path = "/home";
          show_value = false;
          stat = "disk_used_pct";
          type = "sysmon";
        };

        disk-root = {
          path = "/";
          show_value = false;
          stat = "disk_used_pct";
          type = "sysmon";
        };

        layout = {
          capsule = true;
          capsule_fill = "primary";
          color = "on_primary";
          type = "ezequiel/mango_layouts:btn";
        };

        lyrics = {
          cover_shape = "rounded";
          cover_size = 23;
          hide_when_paused = true;
          type = "h465855hgg/lyrics:lyrics";
        };

        nix-monitor = {
          colorize_glyph = false;
          show_text = false;
          type = "avivbintangaringga/nix-monitor:nix-monitor";
        };

        privacy.hide_inactive = true;
        ram.show_value = false;
        temp.show_value = false;
        tray.drawer = true;
        volume.show_label = false;
        
        workspaces = {
          focused_output_only = true;
          hide_when_empty = true;
        };
      };
    };
    #    colors = with config.palette; {
    #      mPrimary = blue.hex;
    #      mOnPrimary = crust.hex;
    #      mSecondary = teal.hex;
    #      mOnSecondary = crust.hex;
    #      mTertiary = mauve.hex;
    #      mOnTertiary = crust.hex;
    #      mError = red.hex;
    #      mOnError = crust.hex;
    #      mSurface = base.hex;
    #      mOnSurface = text.hex;
    #      mSurfaceVariant = surface0.hex;
    #      mOnSurfaceVariant = text.hex;
    #      mOutline = surface1.hex;
    #      mShadow = crust.hex;
    #      mHover = lavender.hex;
    #      mOnHover = crust.hex;
    #    };
  };
}
