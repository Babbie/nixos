{ ... }:
{
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
              adaptiveSync = true;
            }
            {
              criteria = "LG Electronics 27GL850 007NTSUMH150";
              status = "enable";
              transform = "90";
              position = "0,0";
              adaptiveSync = false;
            }
          ];
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
              adaptiveSync = false;
            }
            {
              criteria = "LG Electronics 23MP75 0x0003C8A1";
              status = "enable";
              position = "1920,0";
              adaptiveSync = false;
            }
          ];
        };
      }
      {
        profile = {
          name = "work";
          outputs = [
            {
              criteria = "eDP-1";
              status = "enable";
              scale = 1.333333;
              position = "0,550";
              adaptiveSync = false;
            }
            {
              criteria = "Dell Inc. DELL S2722DZ GMF68H3";
              status = "enable";
              mode = "2560x1440@75Hz";
              position = "1921,0";
              adaptiveSync = false;
            }
          ];
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
              adaptiveSync = false;
            }
            {
              criteria = "*";
              status = "enable";
              position = "1921,0";
              adaptiveSync = false;
            }
          ];
        };
      }
    ];
    systemdTarget = "graphical-session.target";
  };
}
