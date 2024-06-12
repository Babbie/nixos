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
      settings = [
        {
          profile = {
            name = "laptop";
            outputs = [
            {
              criteria = "eDP-1";
              status = "enable";
              scale = 1.0;
            }
            ];
            exec = config.kanshi.exec;
          };
        }
        {
          profile = {
            name = "home";
            outputs = [
            {
              criteria = "eDP-1";
              status = "disable";
            }
            {
              criteria = "LG Electronics LG ULTRAGEAR 308NTABAS360";
              status = "enable";
              mode = "3440x1440";
              position = "1440,550";
            }
            {
              criteria = "LG Electronics 27GL850 007NTSUMH150";
              status = "enable";
              transform = "90";
              position = "0,0";
            }
            ];
            exec = config.kanshi.exec;
          };
        }
        {
          profile = {
            name = "klz";
            outputs = [
            {
              criteria = "eDP-1";
              status = "disable";
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
        }
        {
          profile = {
            name = "wildcard";
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
        }
      ];
      systemdTarget = config.kanshi.systemdTarget;
    };
  };
}
