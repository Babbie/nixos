{ config, lib, pkgs, ... }:

with lib; {
  options = {
    hyprlock.enable = mkEnableOption "hyprlock screen locker";
  };

  config = mkIf config.hyprlock.enable {
    home.packages = with pkgs; [ hyprlock ];
    home.file.".config/hypr/hyprlock.conf" = {
      enable = true;
      text = ''
        general {
          disable_loading_bar = false
          grace = 2 
	}

	background {
          monitor =
          color = rgba(20, 20, 20, 0.7)

	  blur_passes = 8
	  blur_size = 8
	}

	label {
          monitor =
	  position = 0, 100
	  halign = center
	  valign = center
	  text = $ATTEMPTS[$ATTEMPTS failed attempts!]
	  color = rgb(${config.colorScheme.palette.base08})
	  font_size = 28
	  font_family = Fira Sans

	  shadow_passes = 2
	  shadow_size = 3
	  shadow_color = rgba(1a1a1aee)
	}

	input-field {
          monitor =
	  position = 0, 0
	  halign = center
	  valign = center

          size = 300, 50
	  outline_thickness = 2
	  dots_center = true
          outer_color = rgba(${config.colorScheme.palette.base04}ff)
	  inner_color = rgb(${config.colorScheme.palette.base01})
	  font_color = rgb(${config.colorScheme.palette.base05})
	  fade_on_empty = true
	  fade_timeout = 1000
	  rounding = 10
          check_color = rgba(${config.colorScheme.palette.base0A}ff)
          fail_color = rgba(${config.colorScheme.palette.base08}ff)

	  shadow_passes = 2
	  shadow_size = 3
	  shadow_color = rgba(1a1a1aee)
	}
      '';
    };
  };
}
