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
      pkgs.fvm
    ];

    programs.vscode = {
      enable = true;
      mutableExtensionsDir = true;
    };
  };
}
