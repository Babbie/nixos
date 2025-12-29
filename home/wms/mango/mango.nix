{ inputs, pkgs, lib, ... }:
{
  imports = [
    ../kanshi.nix
    ../cursor.nix
    ../portal.nix
    inputs.mango.hmModules.mango
  ];
  config =
    let
      flavor = "macchiato";
      palette = (lib.importJSON "${pkgs.catppuccin}/palette/palette.json").${flavor}.colors;
      strip = lib.strings.removePrefix "#";
      blue = strip palette.blue.hex;
      green = strip palette.green.hex;
      teal = strip palette.teal.hex;
      mauve = strip palette.mauve.hex;
      red = strip palette.red.hex;
      surface = strip palette.surface1.hex;
      base = strip palette.base.hex;
    in
      {
      wayland.windowManager.mango = {
        enable = true;
        settings = ''
          # More option see https://github.com/DreamMaoMao/mango/wiki/

          # Startup
          exec-once = noctalia-shell
          exec = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots

          windowrule = tags:2, isopensilent:1, istagsilent:1, appid:vesktop
          exec-once = vesktop

          windowrule = tags:3, isopensilent:1, istagsilent:1, appid:zen.*
          exec-once = zen


          # General
          ## System
          syncobj_enable = 1
          adaptive_sync = 1
          allow_tearing = 2

          ## Focus
          drag_tile_to_tile = 1

          ## Multi-monitor & layouts
          focus_cross_monitor = 1
          exchange_cross_monitor = 1
          scratchpad_cross_monitor = 1
          circle_layout = tgmix,scroller,vertical_tile,vertical_scroller,monocle

          ## Window
          no_border_when_single = 0

          # Input devices
          ## Trackpad
          trackpad_natural_scrolling = 1

          # Visuals
          ## Theming
          borderpx = 2
          gappih = 6
          gappiv = 6
          gappoh = 12
          gappov = 12

          ## Colors
          rootcolor = 0x${base}ff
          bordercolor = 0x${surface}ff
          focuscolor = 0x${blue}ff
          urgentcolor = 0x${red}ff
          maximizescreencolor = 0x${green}ff
          scratchpadcolor = 0x${teal}ff
          globalcolor = 0x${mauve}ff
          overlaycolor = 0x${mauve}ff

          ## Scratchpad appearance
          scratchpad_width_ratio = 0.8
          scratchpad_height_ratio = 0.9

          # Window effects
          ## Blur
          blur = 1
          blur_layer = 0
          blur_optimized = 1
          blur_params_radius = 3
          blur_params_num_passes = 3

          ## Shadows
          shadows = 1
          layer_shadows = 0
          shadow_only_floating = 1
          shadows_size = 10
          shadows_blur = 15
          shadows_position_x = 0
          shadows_position_y = 0
          shadowscolor= 0x000000ff

          ## Opacity & Corner Radius
          border_radius = 12
          no_radius_when_single = 0
          focused_opacity = 1.0
          unfocused_opacity = 0.95

          # Animations
          ## Enabling
          animations = 1
          layer_animations = 0

          ## Types
          animation_type_open = zoom
          animation_type_close = zoom
          layer_animation_type_open = zoom
          layer_animation_type_close = zoom

          ## Fade
          animation_fade_in = 1
          animation_fade_out = 1
          fadein_begin_opacity = 0.5
          fadeout_begin_opacity = 0.8

          ## Zoom
          zoom_initial_ratio = 0.3
          zoom_end_ratio = 0.7

          ## Durations
          animation_duration_move = 350
          animation_duration_open = 350
          animation_duration_tag = 350
          animation_duration_close = 200
          animation_duration_focus = 350

          ## Curves
          animation_curve_move = 0.46,1.0,0.29,1
          animation_curve_open = 0.17,0.89,0.10,1.08
          animation_curve_opafadein = 0.46,1.0,0.29,1
          animation_curve_close = 0.08,0.92,0,1
          animation_curve_opafadeout = 0.5,0.5,0.5,0.5
          animation_curve_tag = 0.46,1.0,0.29,1
          animation_curve_focus = 0.46,1.0,0.29,1

          # Layouts
          ## Scroller
          scroller_structs = 20
          scroller_default_proportion = 0.8
          scroller_focus_center = 0
          scroller_prefer_center = 0
          edge_scroller_pointer_focus = 1
          scroller_proportion_preset = 0.5,0.8,1.0
          scroller_default_proportion_single = 1.0

          ## Master-Stack
          new_is_master = 1
          default_mfact = 0.55
          default_nmaster = 1
          smartgaps = 0
          center_master_overspread = 1
          center_when_single_stack = 0

          ## Overview
          enable_hotarea = 1
          hotarea_size = 10
          ov_tab_mode = 0
          overviewgappi = 30
          overviewgappo = 30

          # Rules
          tagrule=id:1,monitor_name:eDP-1,layout_name:tgmix
          tagrule=id:2,monitor_name:eDP-1,layout_name:tgmix
          tagrule=id:3,monitor_name:eDP-1,layout_name:tgmix
          tagrule=id:4,monitor_name:eDP-1,layout_name:tgmix
          tagrule=id:5,monitor_name:eDP-1,layout_name:tgmix
          tagrule=id:6,monitor_name:eDP-1,layout_name:tgmix
          tagrule=id:7,monitor_name:eDP-1,layout_name:tgmix
          tagrule=id:8,monitor_name:eDP-1,layout_name:tgmix
          tagrule=id:9,monitor_name:eDP-1,layout_name:tgmix

          ## Let Noctalia handle its own animations and disable blur for it (bugs out)
          layerrule = noblur:1,noanim:1,layer_name:noctalia.*

          # Key Bindings

          ## Mango
          bind = SUPER+SHIFT          ,r      ,reload_config
          bind = SUPER+CTRL+SHIFT+ALT ,q      ,quit

          ## Spawns
          bind = SUPER                ,Return ,spawn,kitty
          bind = SUPER                ,space  ,spawn,noctalia-shell ipc call launcher toggle
          bind = CTRL+ALT+SHIFT       ,l      ,spawn,noctalia-shell ipc call lockScreen lock

          ## Misc
          bind = SUPER+SHIFT          ,q      ,killclient
          bind = SUPER                ,b      ,toggle_render_border
          bind = SUPER+SHIFT          ,b      ,togglegaps
          bind = ALT                  ,Tab    ,toggleoverview,
          bind = SUPER                ,z      ,toggle_scratchpad
          bind = SUPER                ,n      ,switch_layout
          mousebind = NONE            ,btn_left,toggleoverview,1
          mousebind = NONE            ,btn_right,killclient,0
          gesturebind = NONE          ,up,3   ,toggleoverview

          ### Scroller
          bind = SUPER                ,e      ,set_proportion,1.0
          bind = SUPER                ,x      ,switch_proportion_preset

          ## Focus
          ### Window
          bind = SUPER                ,Tab    ,focusstack,next
          bind = SUPER                ,Left   ,focusdir,left
          bind = SUPER                ,Right  ,focusdir,right
          bind = SUPER                ,Up     ,focusdir,up
          bind = SUPER                ,Down   ,focusdir,down

          ### Tag
          bind = SUPER                ,1      ,view,1
          bind = SUPER                ,2      ,view,2
          bind = SUPER                ,3      ,view,3
          bind = SUPER                ,4      ,view,4
          bind = SUPER                ,5      ,view,5
          bind = SUPER                ,6      ,view,6
          bind = SUPER                ,7      ,view,7
          bind = SUPER                ,8      ,view,8
          bind = SUPER                ,9      ,view,9
          gesturebind = NONE          ,left,3 ,viewtoright
          gesturebind = NONE          ,right,3,viewtoleft

          ### Toggle tag
          bind = SUPER+ALT            ,1      ,toggleview,1
          bind = SUPER+ALT            ,2      ,toggleview,2
          bind = SUPER+ALT            ,3      ,toggleview,3
          bind = SUPER+ALT            ,4      ,toggleview,4
          bind = SUPER+ALT            ,5      ,toggleview,5
          bind = SUPER+ALT            ,6      ,toggleview,6
          bind = SUPER+ALT            ,7      ,toggleview,7
          bind = SUPER+ALT            ,8      ,toggleview,8
          bind = SUPER+ALT            ,9      ,toggleview,9

          ### Monitor
          bind = SUPER+CTRL           ,Left   ,focusmon,left
          bind = SUPER+CTRL           ,Right  ,focusmon,right

          ## Window movement
          ### Window
          bind = SUPER+SHIFT          ,Tab    ,exchange_stack_client,next
          bind = SUPER+SHIFT          ,Left   ,exchange_client,left
          bind = SUPER+SHIFT          ,Right  ,exchange_client,right
          bind = SUPER+SHIFT          ,Up     ,exchange_client,up
          bind = SUPER+SHIFT          ,Down   ,exchange_client,down

          mousebind = SUPER           ,btn_left,moveresize,curmove
          mousebind = SUPER           ,btn_right,moveresize,curresize

          ### Tag
          bind = SUPER+SHIFT          ,1      ,tagsilent,1
          bind = SUPER+SHIFT          ,2      ,tagsilent,2
          bind = SUPER+SHIFT          ,3      ,tagsilent,3
          bind = SUPER+SHIFT          ,4      ,tagsilent,4
          bind = SUPER+SHIFT          ,5      ,tagsilent,5
          bind = SUPER+SHIFT          ,6      ,tagsilent,6
          bind = SUPER+SHIFT          ,7      ,tagsilent,7
          bind = SUPER+SHIFT          ,8      ,tagsilent,8
          bind = SUPER+SHIFT          ,9      ,tagsilent,9

          ### Toggle tag
          bind = SUPER+SHIFT+ALT      ,1      ,toggletag,1
          bind = SUPER+SHIFT+ALT      ,2      ,toggletag,2
          bind = SUPER+SHIFT+ALT      ,3      ,toggletag,3
          bind = SUPER+SHIFT+ALT      ,4      ,toggletag,4
          bind = SUPER+SHIFT+ALT      ,5      ,toggletag,5
          bind = SUPER+SHIFT+ALT      ,6      ,toggletag,6
          bind = SUPER+SHIFT+ALT      ,7      ,toggletag,7
          bind = SUPER+SHIFT+ALT      ,8      ,toggletag,8
          bind = SUPER+SHIFT+ALT      ,9      ,toggletag,9

          ### Monitor
          bind = SUPER+CTRL+SHIFT     ,Left   ,tagmon,left
          bind = SUPER+CTRL+SHIFT     ,Right  ,tagmon,right

          ## Window status
          bind = SUPER                ,g      ,toggleglobal
          bind = SUPER                ,BackSpace,togglefloating
          bind = SUPER                ,m      ,togglemaximizescreen
          bind = SUPER                ,f      ,togglefullscreen
          bind = SUPER+SHIFT          ,f      ,togglefakefullscreen
          bind = SUPER                ,i      ,minimized
          bind = SUPER+SHIFT          ,i      ,restore_minimized

          ## Resize
          ### Enter mode
          bind = SUPER                ,R      ,setkeymode,resize
          keymode = resize

          ### Resize commands
          bind = NONE                 ,Left   ,resizewin,-100,0
          bind = NONE                 ,Right  ,resizewin,+100,0
          bind = NONE                 ,Up     ,resizewin,0,-100
          bind = NONE                 ,Down   ,resizewin,0,+100
          ### Return
          bind = NONE                 ,Escape ,setkeymode,default
        '';
      };
    };
}
