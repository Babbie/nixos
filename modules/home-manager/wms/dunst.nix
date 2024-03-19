{ config, lib, pkgs, ... }:

with lib; {
  options = {
    dunst.enable = mkEnableOption "dunst notification daemon";
  };

  config = mkIf config.dunst.enable {
    fonts.fontconfig.enable = true;
    home.packages = [ pkgs.fira ];
    services.dunst = {
      enable = true;
      settings =
        let 
          palette = config.colorScheme.palette;
        in {
	  global = {
	    follow = "mouse";
	    width = "(150, 500)";
	    height = 300;
	    origin = "top-right";
            offset = "5x5";
	    notification_limit = 5;
	    progress_bar_height = 15;
	    progress_bar_frame_width = 2;
	    transparency = 10;
	    separator_height = 2;
	    padding = 10;
	    horizontal_padding = 10;
	    text_icon_padding = 10;
	    frame_width = 2;
	    corner_radius = 10;
	    sort = true;

	    font = "Fira Sans 11";
	    markup = true;
	    format = "<i>%a</i>\\n<b>%s</b>\\n%b";
	    alignment = "right";
	    vertical_alignment = "center";
	    show_age_threshold = 60;
	    ellipsize = "middle";
	    ignore_newline = false;
	    stack_duplicates = true;
	    show_indicators = true;

            icon_position = "right";
	    min_icon_size = 64;
	    max_icon_size = 64;
	    # icon_path = "";

	    sticky_history = false;
	    history_length = 20;

            mouse_left_click = "do_action, close_current";
	    mouse_middle_click = "close_all";
	    mouse_right_click = "context";

            frame_color = "#${palette.base0B}";
            separator_color = "#${palette.base0B}";
          };

	  urgency_low = {
            background = "#${palette.base01}DD";
            foreground = "#${palette.base04}";
	    timeout = 10;
	  };

	  urgency_normal = {
            background = "#${palette.base02}DD";
            foreground = "#${palette.base05}";
	    timeout = 10;
	  };
	  
	  urgency_critical = {
            background = "#${palette.base08}DD";
            foreground = "#${palette.base00}";
	    timeout = 0;
	  };
        };
    };
  };
}
