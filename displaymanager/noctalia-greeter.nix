{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  config = {
    programs.uwsm = {
      enable = true;
      waylandCompositors = {
        mango = {
          prettyName = "Mango";
          comment = "Mango compositor managed by UWSM";
          binPath = lib.getExe inputs.mango.packages."x86_64-linux".mango;
        };
      };
    };
    environment.sessionVariables = {
      UWSM_SILENT_START = "2";
    };
    services.displayManager.noctalia-greeter = {
      enable = true;
      cursorTheme = {
        name = "Posy_Cursor_Black";
        package = pkgs.posy-cursors;
      };
      settings = {
        appearance = {
          scheme = "Synced";
          password_style = "random";
          hide_logo = true;
          scheme_selector_position = "hidden";
        };
        cursor.size = 24;
        keyboard.layout = "us";
      };
    };

    security.polkit = {
      enable = true;
      enablePkexecWrapper = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
          var allowedUsers = ["bab"];
          if (action.id == "org.noctalia.greeter.sync-appearance" &&
              action.lookup("program") == "${config.services.displayManager.noctalia-greeter.package}/bin/noctalia-greeter-apply-appearance" &&
              action.lookup("user") == "root" &&
              subject.local && subject.active &&
              allowedUsers.indexOf(subject.user) >= 0) {
            return polkit.Result.YES;
          }
        });
      '';
    };
  };
}
