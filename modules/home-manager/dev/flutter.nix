{ lib, config, pkgs, ... }:

with lib; {
  imports = [
  ];

  options = {
    flutter.enable = mkEnableOption "Enable flutter dev environment";
  };

  config = mkIf config.flutter.enable {
    home.packages = [
      pkgs.android-studio
      (lowPrio pkgs.flutter)
      pkgs.unzip
    ];

    home.sessionPath = [ "$HOME/.pub-cache/bin" ]

    programs.vscode = {
      enable = true;
      mutableExtensionsDir = true;
    };
  };
}
