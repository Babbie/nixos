{ config, lib, pkgs, ... }:

with lib; {
  options = {
    kanshi.enable = mkEnableOption "kanshi monitor manager";
    kanshi.systemdTarget = mkOption {
      type = with types; uniq str;
      description = "Systemd target to bind to";
    };
    kanshi.exec = mkOption {
      default = [];
      description = "Commands to execute on profile switch";
    };
  };

  config = mkIf config.kanshi.enable {
    home.packages = [ pkgs.kanshi ];
    services.kanshi = {
      enable = true;
      profiles = {
        laptop = {
          outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            scale = 1.0;
          }
          ];
          exec = config.kanshi.exec;
        };
        klz = {
          outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
            scale = 1.0;
          }
          {
            criteria = "Iiyama North America PL2783Q 1142982501719";
            status = "enable";
            position = "0,0";
          }
          {
            criteria = "LG Electronics 23MP75 ";
            status = "enable";
            position = "1920,0";
          }
          ];
          exec = config.kanshi.exec;
        };
        "single" = {
          outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            scale = 1.333333;
          }
          {
            criteria = "*";
            status = "enable";
          }
          ];
          exec = config.kanshi.exec;
        };
        "double" = {
          outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
            scale = 1.0;
          }
          {
            criteria = "*";
            status = "enable";
          }
          {
            criteria = "*";
            status = "enable";
          }
          ];
          exec = config.kanshi.exec;
        };
      };
      systemdTarget = config.kanshi.systemdTarget;
    };
  };
}
