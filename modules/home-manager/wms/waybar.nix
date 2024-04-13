{ config, lib, pkgs, home, nix-colors, ... }:

with lib; {
  options = {
    waybar.enable = mkEnableOption "Enable waybar";
    waybar.wm = mkOption {
      default = "hyprland";
      description = "The wm in use";
    };
    waybar.secondaryDisk = mkOption {
      default = "";
      description = "The path to a secondary disk";
    };
    waybar.hwmonPath = mkOption {
      default = "/sys/class/hwmon/hwmon2/temp1_input";
      description = "The path to a temperature readout";
    };
  };
  
  config = mkIf config.waybar.enable {
    fonts.fontconfig.enable = true;
    home.packages = [ 
      pkgs.fira
      (pkgs.nerdfonts.override {
        fonts = [ "FiraCode" ];
      })
    ];
    programs.waybar =
      let 
        RGBString = nix-colors.lib.conversions.hexToRGBString ", ";
	palette = config.colorScheme.palette;
      in {
        enable = true;
        systemd.enable = true;
        style = ''
          * {
            color: #${palette.base05};
            /* `otf-font-awesome` is required to be installed for icons */
            font-family: Fira Sans, FiraCode Nerd Font, Roboto, Helvetica, Arial, sans-serif;
            font-size: 15px;
            font-weight: bold;
          }
          
          window#waybar, window#waybar.empty {
            background: rgba(${RGBString palette.base01}, 0.5);
            background-clip: content-box;
            border-bottom: 2px solid rgba(${RGBString palette.base04}, 0.5);
            transition-property: background, border;
            transition-duration: 0.5s;
          }
          
          window#waybar.solo {
	    background: rgba(${RGBString palette.base01}, 1);
            border-bottom: 2px solid rgba(${RGBString palette.base04}, 1);
          }

          tooltip {
            background: rgba(${RGBString palette.base00}, 0.9);
            border: 2px solid rgba(${RGBString palette.base0B}, 1);
          }
          
          button {
            /* Use box-shadow instead of border so the text isn't offset */
            box-shadow: inset 0 -2px transparent;
            /* Avoid rounded borders under each button name */
            border: none;
            border-radius: 0;
          }
          
          /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
          button:hover {
            background: inherit;
            box-shadow: inset 0 -2px #${palette.base05};
          }

          #workspaces button {
            padding: 0 5px;
            background: transparent;
            color: #${palette.base05};
          }
          
          #workspaces button:hover {
            background: rgba(${RGBString palette.base04}, 0.5);
            box-shadow: inset 0 -2px #${palette.base05};
            text-shadow: inherit;
          }
          
          #workspaces button.active {
            background: rgba(${RGBString palette.base02}, 0.5);
            box-shadow: inset 0 -2px rgba(${RGBString palette.base05}, 0.7);
          }

          #workspaces button.active:hover {
            background: rgba(${RGBString palette.base04}, 0.5);
            box-shadow: inset 0 -2px #${palette.base05};
            text-shadow: inherit;
          }
          
          #workspaces button.urgent {
            background: rgba(${RGBString palette.base0A}, 0.5);
            box-shadow: inset 0 -2px #${palette.base0A};
          }
          
          #battery,
          #pulseaudio,
          #network,
          #disk,
          #cpu,
          #memory,
          #temperature,
          #clock,
          #tray {
	    transition-property: border;
            transition-duration: 0.5s;
            padding: 0 10px;
          }
          
          #window,
          #workspaces {
            margin: 0 4px;
          }
          
          /* If workspaces is the leftmost module, omit left margin */
          .modules-left > widget:first-child > #workspaces {
            margin-left: 0;
          }
          
          #battery {
            border-bottom: 2px solid rgba(${RGBString palette.base0E}, 0.7);
          }
          .solo #battery {
            border-bottom: 2px solid rgba(${RGBString palette.base0E}, 1);
          }
          
          /* Using steps() instead of linear as a timing function to limit cpu usage */
          #battery.critical:not(.charging) {
            animation-name: blink;
            animation-duration: 0.5s;
            animation-timing-function: steps(12);
            animation-iteration-count: infinite;
            animation-direction: alternate;
          }

          #pulseaudio {
            border-bottom: 2px solid rgba(${RGBString palette.base08}, 0.7);
          }
          .solo #pulseaudio {
            border-bottom: 2px solid rgba(${RGBString palette.base08}, 1);
          }
          
          #network {
            border-bottom: 2px solid rgba(${RGBString palette.base09}, 0.7);
          }
          .solo #network {
            border-bottom: 2px solid rgba(${RGBString palette.base09}, 1);
          }
          
          #disk {
            border-bottom: 2px solid rgba(${RGBString palette.base0A}, 0.7);
          }
          .solo #disk {
            border-bottom: 2px solid rgba(${RGBString palette.base0A}, 1);
          }
          
          #cpu {
            border-bottom: 2px solid rgba(${RGBString palette.base0B}, 0.7);
          }
          .solo #cpu {
            border-bottom: 2px solid rgba(${RGBString palette.base0B}, 1);
          }

          #memory {
            border-bottom: 2px solid rgba(${RGBString palette.base0C}, 0.7);
          }
          .solo #memory {
            border-bottom: 2px solid rgba(${RGBString palette.base0C}, 1);
          }
          
          @keyframes blink {
              to {
                  background: #${palette.base08};
                  color: #${palette.base00};
              }
          }

          #temperature {
            border-bottom: 2px solid rgba(${RGBString palette.base0D}, 0.7);
          }
          .solo #temperature {
            border-bottom: 2px solid rgba(${RGBString palette.base0D}, 1);
          }

          /* Using steps() instead of linear as a timing function to limit cpu usage */
          #temperature.critical {
            animation-name: blink;
            animation-duration: 0.5s;
            animation-timing-function: steps(12);
            animation-iteration-count: infinite;
            animation-direction: alternate;
          }

          #clock {
            border-bottom: 2px solid rgba(${RGBString palette.base0E}, 0.7);
          }
          .solo #clock {
            border-bottom: 2px solid rgba(${RGBString palette.base0E}, 1);
          }
          
          #tray {
            border-bottom: 2px solid rgba(${RGBString palette.base08}, 0.7);
          }
          .solo #tray {
            border-bottom: 2px solid rgba(${RGBString palette.base08}, 1);
          }
          
          #tray > .passive {
              -gtk-icon-effect: dim;
          }
          
          #tray > .needs-attention {
              -gtk-icon-effect: highlight;
              background: #${palette.base0A};
          }
        '';
        settings = {
          mainBar = {
            layer = "top";
            height = 30; # Waybar height (to be removed for auto height)
            spacing = 0; # Gaps between modules
            # Choose the order of the modules
            modules-left = [
              "${config.waybar.wm}/workspaces"
            ];
            modules-center = [
              "${config.waybar.wm}/window"
            ];
            modules-right = [
              "battery"
              "pulseaudio"
              "network"
              "disk"
              "disk#secondary"
              "cpu"
              "memory"
              "temperature"
              "clock"
              "tray"
            ];
            #Modules configuration
            "${config.waybar.wm}/workspaces" = {
              
            };
            battery = {
              states = {
                critical = 15;
              };
              format = "{capacity}% {icon}";
              format-full = "{capacity}% 󱟢";
              format-charging = "{capacity}% 󰚥";
              format-plugged = "{capacity}% 󰚥";
              format-critical = "{capacity}% 󰂃";
              format-alt = "{time} {icon}";
              format-icons = [ "󰁺" "󰁼" "󰁾" "󰂀" "󰂂" ];
            };
            pulseaudio = {
              format = "{volume}% {icon}";
              format-bluetooth = "{volume}% {icon}󰂯";
              format-bluetooth-muted = "󰝟 {icon}󰂯";
              format-muted = "󰝟";
              format-icons = {
                headphone = "󰋋";
                hands-free = "󰋎";
                headset = "󰋎";
                default = [ "󰕿" "󰖀" "󰕾" ];
              };
              on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
              on-click-right = "${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
	      reverse-scrolling = true;
	      smooth-scrolling-threshold = 2;
            };
            network = {
              format-wifi = "{essid} ({signalStrength}%) {icon}";
              format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
              format-ethernet = "{ipaddr}/{cidr} 󰌘";
              tooltip-format = "{ifname} via {gwaddr}";
              format-linked = "{ifname} (No IP) 󰌚";
              format-disconnected = "Disconnected 󰌙";
              format-alt = "{ifname}: {ipaddr}/{cidr}";
              on-click-right = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
            };
            disk = {
              format = "{percentage_used}% 󰆼";
              path = "/";
            };
            "disk#secondary" = {
              format = "{percentage_used}% 󱘲";
              path = config.waybar.secondaryDisk;
            };
            cpu = {
              format = "{usage}% 󰍛";
            };
            memory = {
              format = "{percentage}% 󰘚";
              tooltip-format = "{used:0.1f}GiB used out of {total:0.1f}GiB";
            };
            temperature = {
              hwmon-path = config.waybar.hwmonPath;
              critical-threshold = 80;
              format = "{temperatureC}°C {icon}";
              format-icons = [ "󱃃" "󰔏" "󱃂" ];
            };
            tray = {
              icon-size = 21;
              spacing = 10;
            };
            clock = {
              tooltip-format = "<span size='9pt' font='FiraCode Nerd Font'>{calendar}</span>";
              format-alt = "{:%Y-%m-%d}";
              calendar = {
                weeks-pos = "left";
                format = {
                  today = "<span color='#${palette.base0B}'><b>{}</b></span>";
                };
              };
            };
          };
        };
    };
  };
}
