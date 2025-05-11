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
      (pkgs.buildFHSEnv {
        name = "fvm env";
        targetPkgs = pkgs: ([ pkgs.fvm ]);
      }).env
      pkgs.unzip
    ];

    programs.vscode = {
      enable = true;
      mutableExtensionsDir = true;
    };
  };
}
