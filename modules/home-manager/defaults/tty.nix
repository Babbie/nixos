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
        package = pkgs.nerdfonts.fira-code;
        name = "FiraCode Nerd Font";
        size = 11;
      };
      themeFile = "Catppuccin-Macchiato";
    };
  };
}
