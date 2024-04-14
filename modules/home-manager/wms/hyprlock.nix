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
          fetchPatch {
            url = "https://raw.githubusercontent.com/NixOS/nixpkgs/68ed9da5e3ef13bf80fa22ff99dcb1d39bcf72dc/pkgs/by-name/hy/hyprlock/cmake.patch";
	    hash = "";
	  }
	];
        src = fetchFromGitHub {
          owner = "hyprwm";
          repo = "hyprlock";
          rev = "v0.3.0";
          # If you don't know the hash, the first time, set:
          # hash = "";
          # then nix will fail the build with such an error message:
          # hash mismatch in fixed-output derivation '/nix/store/m1ga09c0z1a6n7rj8ky3s31dpgalsn0n-source':
          # specified: sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
          # got:    sha256-173gxk0ymiw94glyjzjizp8bv8g72gwkjhacigd1an09jshdrjb4
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
          color = rgba(20, 20, 20, 0.7)

	  blur_passes = 8
	  blur_size = 8
	}

	label {
          monitor =
	  position = 0, 100
	  halign = center
	  valign = center
	  text = $ATTEMPTS[] $ATTEMPTS failed attempts!
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
