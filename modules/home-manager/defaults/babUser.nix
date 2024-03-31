{ lib, config, pkgs, ... }:

with lib; {
  options = {
    babUserHome.enable = mkOption {
      default = true;
      description = "Enable default user home settings";
    };
  };

  config = mkIf config.babUserHome.enable {
    home.username = "bab";
    home.homeDirectory = "/home/bab";
    home.sessionPath = [ "$HOME/.scripts" ];
    home.sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
