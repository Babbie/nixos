{ lib, config, pkgs, ... }:

with lib; {
  options = {
    tty.enable = mkOption {
      default = true;
      description = "Enable default terminal settings";
    };
  };

  config = mkIf config.tty.enable {
    programs.kitty = {
      enable = true;
      font = {
        package = pkgs.nerdfonts.override {
	  fonts = [ "FiraCode" ];
	};
        name = "FiraCode Nerd Font";
        size = 11;
      };
      themeFile = "Catppuccin-Macchiato";
    };
  };
}
