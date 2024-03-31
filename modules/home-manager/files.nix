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
      source = "../../files/wallpapers";
    };
  };
}
