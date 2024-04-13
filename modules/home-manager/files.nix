{ lib, config, pkgs, ... }:

with lib; {
  imports = [
  ];

  options = {
    wallpapers.enable = mkOption {
      default = true;
      description = "Store wallpapers in $HOME/.wallpapers";
    };
  };

  config = {
    home.file.".wallpapers" = {
      enable = config.wallpapers.enable;
      source = ../../files/wallpapers;
    };
    home.file.".scripts" = {
      enable = true;
      source = ../../scripts;
      recursive = true;
    };
    home.file.".scripts/wallpaper" = {
      enable = true;
      text = '' 
        #!/usr/bin/env bash
	pkill swaybg
	swaybg -i $(find ${config.home.homeDirectory}/.wallpapers -type f | shuf -n1) -m fill > /dev/null 2>&1 &
      '';
      executable = true;
    };
  };
}
