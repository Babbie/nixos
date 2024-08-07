{ config, lib, pkgs, ... }:

with lib; {
  options = {
    hyprlock.enable = mkEnableOption "hyprlock screen locker";
  };

  config = mkIf config.hyprlock.enable {
    home.packages = with pkgs; [
      hyprlock
    ];
    home.file.".images/lock.png" = {
      enable = true;
      source = ../../../files/lock.png;
    };
    home.file.".config/hypr/hyprlock.conf" = {
      enable = true;
      text = ''
      general {
        grace = 2 
          ignore_empty_input = true
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

      image {
        position = 0, 60
          halign = center
          valign = center
          rounding = 0
          border_size = 0
          path = ~/.images/lock.png
          size = 267
      }

      label {
        monitor =
          position = 0, -100
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
          fade_on_empty = true
          fade_timeout = 1000
          placeholder_text =
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
