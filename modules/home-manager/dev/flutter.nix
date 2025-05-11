{ lib, config, pkgs, ... }:

with lib; {
  imports = [
  ];

  options = {
    flutterDev.enable = mkEnableOption "Enable flutter dev environment";
  };

  config = mkIf config.flutterDev.enable {
    home.packages = [
      pkgs.android-studio
      pkgs.fvm
    ];

    programs.vscode = {
      enable = true;
      mutableExtensionsDir = true;
      package = pkgs.vscode-with-extensions;
    };
  };
}
