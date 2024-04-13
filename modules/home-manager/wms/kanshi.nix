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
	    }
	  ];
        };
        klz = {
	  outputs = [
	    {
              criteria = "eDP-1";
	      status = "disable";
	    }
	    {
	      criteria = "DP-2";
	    }
	    {
	      criteria = "DP-3";
	      position = "1920,0";
	    }
	  ];
	  exec = config.kanshi.exec;
        };
	unknown = {
          outputs = [
            {
	      criteria = "*";
	    }
	  ];
	};
      };
      systemdTarget = config.kanshi.systemdTarget;
    };
  };
}
