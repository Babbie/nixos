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

    programs.vscode = {
      enable = true;
      mutableExtensionsDir = true;
    };
  };
}
