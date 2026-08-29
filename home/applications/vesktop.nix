{ config, ... }:
{
  imports = [ 
    ../../util/palette.nix
  ];

  programs.vesktop = {
    enable = true;
    settings = 
      let 
        p = config.palette; 
        rgbString = (rgb: "rgb(${toString rgb.r}, ${toString rgb.g}, ${toString rgb.b})");
      in {
        hardwareAcceleration = true;
        hardwareVideoAcceleration = false;
        splashTheming = true;
        splashBackground = rgbString p.base.rgb;
        splashColor = rgbString p.text.rgb;
        tray = true;
      };
    vencord = {
      settings = {
        autoUpdate = true;
        autoUpdateNotification = true;
        plugins = {
          AnonymiseFileNames.enabled = true;
          BetterGifAltText.enabled = true;
          ChatInputButtonAPI.enabled = true;
          ClearURLs.enabled = true;
          CommandsAPI.enabled = true;
          CopyFileContents.enabled = true;
          CrashHandler.enabled = true;
          Dearrow = {
            enabled = true;
            hideButton = false;
            replaceElements = 0;
            dearrowByDefault = true;
          };
          MemberListDecoratorsAPI.enabled = true;
          MessageAccessoriesAPI.enabled = true;
          MessageDecorationsAPI.enabled = true;
          MessageEventsAPI.enabled = true;
          ServerListAPI.enabled = true;
          UserSettingsAPI.enabled = true;
          FakeNitro = {
            enabled = true;
            enableEmojiBypass = true;
            emojiSize = 48;
            transformEmojis = true;
            enableStickerBypass = true;
            stickerSize = 160;
            transformStickers = true;
            transformCompoundSentence = true;
            enableStreamQualityBypass = true;
            useHyperLinks = true;
            hyperLinkText = "{{NAME}}";
            disableEmbedPermissionCheck = false;
          };
          FixSpotifyEmbeds = {
            enabled = true;
            volume = 10;
          };
          FixYoutubeEmbeds.enabled = true;
          ForceOwnerCrown.enabled = true;
          MemberCount.enabled = true;
          NoOnboardingDelay.enabled = true;
          NoProfileThemes.enabled = true;
          OpenInApp = {
            enabled = true;
            spotify = true;
            steam = true;
            epic = false;
            tidal = false;
            itunes = false;
          };
          PlatformIndicators = {
            enabled = true;
            list = true;
            badges = true;
            messages = true;
            colorMobileIndicator = true;
          };
          PreviewMessage.enabled = true;
          RoleColorEverywhere.enabled = true;
          SendTimestamps = {
            enabled = true;
            replaceMessageContents = true;
          };
          TypingIndicator = {
            enabled = true;
            includeCurrentChannel = true;
            includeMutedChannels = true;
            includeBlockedUsers = true;
          };
          Unindent.enabled = true;
          UserMessagesPronouns.enabled = true;
          ValidReply.enabled = true;
          ValidUser.enabled = true;
          VoiceMessages = {
            enabled = true;
            noiseSuppression = true;
            echoCancellation = true;
          };
          VolumeBooster = {
            enabled = true;
            multiplier = 2;
          };
          WebKeybinds.enabled = true;
          WebScreenShareFixes.enabled = true;
          WhoReacted.enabled = true;
          YoutubeAdblock.enabled = true;
          BadgeAPI.enabled = true;
          NoTrack = {
            enabled = true;
            disableAnalytics = true;
          };
          Settings = {
            enabled = true;
            settingsLocation = "aboveNitro";
          };
          DisableDeepLinks.enabled = true;
          SupportHelper.enabled = true;
          WebContextMenus.enabled = true;
        };
      };
    };
  };
}
