{
  programs.keepassxc = {
    autostart = true;
    enable = true;
    settings = {
      General = {
        ConfigVersion = 2;
        MinimizeAfterUnlock = true;
      };
      GUI = {
        ApplicationTheme = "dark";
        ShowTrayIcon = true;
        MinimizeToTray = true;
        MinimizeOnClose = true;

      };
      FdoSecrets = {
        Enabled = true;
        ShowNotification = false;
      };
      Security = {
        LockDatabaseIdle = false;
      };
      # Just here to make it not try to write to config, causing a red warning
      PasswordGenerator = {
        AdditionalChars = "";
        ExcludedChars = "";
      };
    };
  };

  xdg.autostart.enable = true;
}
