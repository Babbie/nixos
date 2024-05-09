{ lib, config, pkgs, ... }:

with lib; {
  imports = [
  ];

  options = {
    greetd.enable = mkOption {
      default = true;
      description = "Enable default packages";
    };
    greetd.command = mkOption {
      default = "Hyprland > $HOME/.hyprland.log 2>&1";
      description = "Greetd initial_session command";
    };
    greetd.user = mkOption {
      default = "bab";
      description = "Greetd initial_session user";
    };
  };

  config = mkIf config.greetd.enable {
    services.greetd.enable = true;
    services.greetd = {
      settings = rec {
        initial_session = {
          command = config.greetd.command;
          user = config.greetd.user;
        };
        default_session = initial_session;
      };
    };
  };
}
