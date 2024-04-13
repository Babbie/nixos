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
    services.kanshi = {
      enable = true;
      profiles = {
        laptop = {
	  outputs = [
	    {
              criteria = "eDP-1";
	      status = "enable";
	    }
	  ];
	  exec = config.kanshi.exec;
        };
        klz = {
	  outputs = [
	    {
              criteria = "eDP-1";
	      status = "disable";
	    }
	    {
	      criteria = "Iiyama North America PL2783Q 1142982501719";
	      status = "enable";
	    }
	    {
	      criteria = "LG Electronics 23MP75 Unknown";
	      status = "enable";
	      position = "1920,0";
	    }
	  ];
	  exec = config.kanshi.exec;
        };
	unknown = {
          outputs = [
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
