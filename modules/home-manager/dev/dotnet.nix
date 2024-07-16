{ lib, config, pkgs, ... }:

with lib; {
  imports = [
  ];

  options = {
    dotNetDev.enable = mkEnableOption "Enable dotnet dev environment";
  };

  config = mkIf config.dotNetDev.enable {
    home.packages = [
      pkgs.jetbrains.rider
      pkgs.android-studio
    ];
  };
}
