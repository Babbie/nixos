{ config, lib, pkgs, ... }:

with lib; {
  options = {
    hyprlock.enable = mkEnableOption "hyprlock screen locker";
  };

  config = mkIf config.hyprlock.enable {
    home.packages = with pkgs; [
      (hyprlock.overrideAttrs ({
        version = "0.3.0";
	patches = [
          (fetchpatch {
            url = "https://raw.githubusercontent.com/NixOS/nixpkgs/68ed9da5e3ef13bf80fa22ff99dcb1d39bcf72dc/pkgs/by-name/hy/hyprlock/cmake.patch";
	    hash = "sha256-OPD2iWYm8kE5zjQWDNAoIrEI6hcdqGQB+7SibZZF8H8=";
	  })
	];
        src = fetchFromGitHub {
          owner = "hyprwm";
          repo = "hyprlock";
          rev = "v0.3.0";
          hash = "sha256-rbzVe2WNdHynJrnyJsKOOrV8yuuJ7QIuah3ZHWERSnA=";
        };
      }))
    ];
    home.file.".config/hypr/hyprlock.conf" = {
      enable = true;
      text = ''
        general {
          disable_loading_bar = false
          grace = 2 
	}

	background {
          monitor =
	  path = screenshot
          #color = rgba(20, 20, 20, 0.7)

	  blur_passes = 2
	  blur_size = 3
	  noise = 0.0
	  contrast = 0.8
	  brightness = 0.6
	  vibrancy = 0.2
	  vibrancy_darkness = 0.0
	}

	label {
          monitor =
	  position = 0, 100
	  halign = center
	  valign = center
	  text = cmd[update:500] if [[ $ATTEMPTS -gt 0 ]]; then echo "$ATTEMPTS failed attempt(s)!"; else echo ""; fi
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

          size = 500, 80
	  outline_thickness = 2
	  dots_center = true
          outer_color = rgba(${config.colorScheme.palette.base04}ff)
	  inner_color = rgb(${config.colorScheme.palette.base01})
	  font_color = rgb(${config.colorScheme.palette.base05})
	  fade_on_empty = false
	  placeholder_text = cmd[] echo "<span foreground='#${config.colorScheme.palette.base05}'>󰌾</span>"
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
