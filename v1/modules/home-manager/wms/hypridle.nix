{ config, lib, pkgs, ... }:

with lib; {
  options = {
    hypridle.enable = mkEnableOption "hypridle idle management daemon";
  };

  config = mkIf config.hypridle.enable {
    home.packages = with pkgs; [ hypridle brightnessctl ];
    hyprlock.enable = true;
    home.file.".config/hypr/hypridle.conf" = {
      enable = true;
      text = ''
        general {
	  lock_cmd = pidof hyprlock || hyprlock    # prevent double processes
	  unlock_cmd = pkill -USR1 hyprlock
	  before_sleep_cmd = loginctl lock-session
	  after_sleep_cmd = hyprctl dispatch dpms on
	}

        listener {
          timeout = 150
	  on-timeout = brightnessctl -s set 10
	  on-resume = brightnessctl -r
	}

	listener {
	  timeout = 180
	  on-timeout = loginctl lock-session
	}

	listener {
          timeout = 210
	  on-timeout = hyprctl dispatch dpms off
	  on-resume = hyprctl dispatch dpms on
	}

	listener {
	  timeout = 1800
	  on-timeout = systemctl suspend
	}
      '';
    };
  };
}
