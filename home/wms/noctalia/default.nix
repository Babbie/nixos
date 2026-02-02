{ inputs, config, pkgs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default

    ../../../util/palette.nix
  ];
  home.packages = with pkgs; [ 
    brightnessctl 
    gpu-screen-recorder
    # To insert calendar events, run evolution via nix-shell
    evolution-data-server
  ];

  home.file.".config/noctalia/plugins" = {
    recursive = true;
    source = pkgs.fetchFromGitHub {
      owner = "noctalia-dev";
      repo = "noctalia-plugins";
      rev = "91b121df5d1331b7dcad7f4db25263cea4562827";
      hash = "sha256-S1gvbIEHrZ0F4wHT2rLununkbqYYrMXW0S5zX7yqJtw=";
      sparseCheckout = [ 
        "mangowc-layout-switcher" 
        "privacy-indicator"
        "screen-recorder"
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
  home.file.".config/noctalia/plugins/screen-recorder/settings.json" = {
    text = builtins.toJSON {
      hideInactive = true;
      copyToClipboard = true;
      directory = "/home/bab/Videos/ScreenRecordings/";
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
        mangowc-layout-switcher.enabled = true;
        privacy-indicator.enabled = true;
        screen-recorder.enabled = true;
      };
    };
  };

  programs.noctalia-shell = {
    enable = true;
    package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.override { calendarSupport = true; };
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
              id = "Tray";
              blacklist = [];
              colorizeIcons = false;
              drawerEnabled = false;
              hidePassive = true;
              pinned = [];
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
            {
              id = "plugin:screen-recorder";
            }
          ];
        };
      };
      general = {
        avatarImage = "/home/bab/.face";
        dimmerOpacity = 0;
        showChangelogOnStartup = true;
        telemetryEnabled = false;
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
        firstDayOfWeek = 1;
        hideWeatherCityName = true;
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
      wallpaper = {
        enabled = true;
        automationEnabled = true;
        directory = "/home/bab/Pictures/Wallpapers";
        fillColor = config.palette.mantle.hex;
        hideWallpaperFilenames = true;
        randomIntervalSec = 3600;
        setWallpaperOnAllMonitors = true;
        transitionDuration = 1000;
        transitionEdgeSmoothness = 0.2;
        transitionType = "random";
        viewMode = "recursive";
        wallpaperChangeMode = "random";
      };
      appLauncher = {
        position = "top_center";
        terminalCommand = "kitty -e";
      };
      controlCenter = {
        diskPath = "/home";
        position = "close_to_bar_button";
        shortcuts = {
          left = [
            {
              id = "Network";
            }
            {
              id = "Bluetooth";
            }
          ];
          right = [
            {
              id = "Notifications";
            }
            {
              id = "KeepAwake";
            }
            {
              id = "plugin:screen-recorder";
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
        overlayLayer = true;
        respectExpireTimeout = true;
        saveToHistory = {
          low = false;
          normal = false;
          critical = true;
        };
        sounds = {
          enabled = true;
          excludedApps = "vesktop,kde connect,slack";
        };
      };
      nightLight = {
        enabled = true;
        autoSchedule = true;
        dayTemp = 6500;
        nightTemp = 2700;
      };
    };
  };
}
