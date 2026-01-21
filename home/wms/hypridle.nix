{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    brightnessctl
    wlr-randr
    jq 
    kanshi
  ];
  services.hypridle = {
    enable = true;
    systemdTarget = "graphical-session.target";
    settings = {
        listener = [
        {
          timeout = 300;
          on-timeout = "brightnessctl --device ${config.backlightDevice} -s set 10";
          on-resume = "brightnessctl --device ${config.backlightDevice} -r";
        }

        {
          timeout = 600;
          on-timeout = "noctalia-shell ipc call lockScreen lock";
        }

        {
          timeout = 660;
          on-timeout = ''${lib.getExe pkgs.wlr-randr} --json | ${lib.getExe pkgs.jq} '.[].name' -r | while IFS= read -r line; do wlr-randr --output "$line" --off; done'';
          on-resume = "${pkgs.kanshi}/bin/kanshictl reload";
        }
      ];
    };
  };
}
