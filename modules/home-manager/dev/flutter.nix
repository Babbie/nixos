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
      (pkgs.flutter.overrideAttrs (previousAttrs: {
        buildPhase = (previousAttrs.buildPhase.removeSuffix "runHook postInstall") ++ "rm .gitignore\nrunHook postInstall";
      }))
    ];
  };
}
