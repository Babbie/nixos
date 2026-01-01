{ inputs, config, pkgs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default

    ../../../util/palette.nix
  ];
  home.packages = [ pkgs.brightnessctl ];

  home.file.".config/noctalia/plugins" = {
    recursive = true;
    source = pkgs.fetchFromGitHub {
      owner = "noctalia-dev";
      repo = "noctalia-plugins";
      rev = "e41dffb965ccb3c2b1e3a69a5bf153c99525e26a";
      hash = "sha256-L8t/nY5/lORGqEtubx/34uSbGyWkQfadGom7w8AZznI=";
      sparseCheckout = [ 
        "mangowc-layout-switcher" 
        "privacy-indicator"
      ];
    };
  };
  home.file.".config/noctalia/plugins/privacy-indicator/settings.json" = {
    text = builtins.toJSON {
      hideInactive = true;
      iconSpacing = 4;
      removeMargins = false;
    };
  };
  home.file.".config/noctalia/plugins.json" = {
    text = builtins.toJSON {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        mangowc-layout-switcher = {
          enabled = true;
        };
        privacy-indicator = {
          enabled = true;
        };
      };
    };
  };

  programs.noctalia-shell = {
    enable = true;
    colors = with config.palette; {
      mPrimary = blue.hex;
      mOnPrimary = crust.hex;
      mSecondary = teal.hex;
      mOnSecondary = crust.hex;
      mTertiary = mauve.hex;
      mOnTertiary = crust.hex;
      mError = red.hex;
      mOnError = crust.hex;
      mSurface = base.hex;
      mOnSurface = text.hex;
      mSurfaceVariant = surface0.hex;
      mOnSurfaceVariant = text.hex;
      mOutline = surface1.hex;
      mShadow = crust.hex;
      mHover = lavender.hex;
      mOnHover = crust.hex;
    };
    settings = {
      bar = {
        widgets = {
          left = [
            {
              id = "plugin:mangowc-layout-switcher";
            }
            {
              id = "Workspace";
              characterCount = 2;
              colorizeIcons = false;
              enableScrollWheel = true;
              followFocusedScreen = false;
              groupedBorderOpacity = 1;
              hideUnoccupied = true;
              labelMode = "index";
              showApplications = true;
              showLabelsOnlyWhenOccupied = true;
              unfocusedIconsOpacity = 0.5;
            }
          ];
          center = [
            {
              id = "ActiveWindow";
              colorizeIcons = false;
              hideMode = "hidden";
              maxWidth = 500;
              scrollingMode = "hover";
              showIcon = true;
              useFixedWidth = false;
            }
          ];
          right = [
            {
              id = "Tray";
              blacklist = [];
              colorizeIcons = false;
              drawerEnabled = false;
              hidePassive = true;
              pinned = [];
            }
            {
              id = "MediaMini";
              hideMode = "hidden";
              hideWhenIdle = false;
              maxWidth = 250;
              scrollingMode = "always";
              showAlbumArt = true;
              showArtistFirst = false;
              showProgressRing = true;
              showVisualizer = true;
              useFixedWidth = true;
              visualizerType = "linear";
            }
            {
              id = "NotificationHistory";
              hideWhenZero = true;
              showUnreadBadge = true;
            }
            {
              id = "Battery";
              deviceNativePath = "";
              displayMode = "onHover";
              hideIfNotDetected = false;
              showNoctaliaPerformance = false;
              showPowerProfiles = true;
              warningThreshold = 15;
            }
            {
              id = "SystemMonitor";
              compactMode = true;
              diskPath = "/home";
              showCpuTemp = true;
              showCpuUsage = true;
              showDiskUsage = true;
              showGpuTemp = false;
              showMemoryAsPercent = true;
              showMemoryUsage = true;
              showNetworkStats = false;
              useMonospaceFont = true;
              usePrimaryColor = false;
            }
            {
              id = "plugin:privacy-indicator";
              hideInactive = true;
            }
            {
              id = "Clock";
              formatHorizontal = "ddd d MMM, h:mm";
              formatVertical = "hh mm - dd MM";
              tooltipFormat = "dddd d MMMM yyyy";
              useCustomFont = false;
              usePrimaryColor = false;
            }
            {
              id = "ControlCenter";
              colorizeSystemIcon = "primary";
              enableColorization = true;
              useDistroLogo = true;
            }
          ];
        };
      };
      general = {
        avatarImage = "/home/bab/.face";
        dimmerOpacity = 0;
      };
      ui = {
        fontDefault = "Fira Sans";
        fontFixed = "FiraCode Nerd Font";
        panelBackgroundOpacity = 1;
      };
      location = {
        analogClockInCalendar = true;
        name = "Groningen";
        showWeekNumberInCalendar = true;
        weatherShowEffects = false;
      };
      calendar = {
        cards = [
          {
            id = "calendar-header-card";
            enabled = true;
          }
          {
            id = "calendar-month-card";
            enabled = true;
          }
          {
            id = "timer-card";
            enabled = true;
          }
          {
            id = "weather-card";
            enabled = true;
          }
        ];
      };
      screenRecorder = {
        copyToClipboard = true;
        directory = "/home/bab/Videos/ScreenRecordings";
      };
      wallpaper = {
        enabled = true;
        directory = "/home/bab/Pictures/Wallpapers";
        fillColor = config.palette.mantle.hex;
        hideWallpaperFilenames = true;
        randomEnabled = true;
        randomIntervalSec = 3600;
        recursiveSearch = true;
        transitionDuration = 1000;
        transitionEdgeSmoothness = 0.2;
      };
      appLauncher = {
        position = "top_center";
        terminalCommand = "kitty -e";
      };
      controlCenter = {
        shortcuts = {
          left = [
            {
              id = "WiFi";
            }
            {
              id = "Bluetooth";
            }
          ];
          right = [
            {
              id = "KeepAwake";
            }
            {
              id = "ScreenRecorder";
            }
          ];
        };
        cards = [
          {
            id = "profile-card";
            enabled = true;
          }
          {
            id = "shortcuts-card";
            enabled = true;
          }
          {
            id = "audio-card";
            enabled = true;
          }
          {
            id = "brightness-card";
            enabled = true;
          }
          {
            id = "weather-card";
            enabled = true;
          }
          {
            id = "media-sysmon-card";
            enabled = true;
          }
        ];
      };
      systemMonitor = {
        diskPath = "/home";
      };
      dock = {
        enabled = false;
      };
      network = {
        wifiEnabled = true;
      };
      sessionMenu = {
        enableCountdown = false;
        position = "top_right";
        showNumberLabels = false;
        powerOptions = [
          {
            action = "lock";
            enabled = true;
          }
          {
            action = "suspend";
            enabled = false;
          }
          {
            action = "hibernate";
            enabled = false;
          }
          {
            action = "reboot";
            enabled = true;
          }
          {
            action = "logout";
            enabled = false;
          }
          {
            action = "shutdown";
            enabled = true;
          }
        ];
      };
      notifications = {
        enabled = true;
        respectExpireTimeout = true;
        saveToHistory = {
          low = false;
          normal = false;
          critical = true;
        };
        sounds = {
          enabled = true;
          excludedApps = "vesktop,kde connect";
        };
      };
      nightLight = {
        enabled = true;
        dayTemp = 6500;
        nightTemp = 2700;
      };
    };
  };
}
