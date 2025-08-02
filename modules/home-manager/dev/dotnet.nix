{ lib, config, pkgs, ... }:

with lib; {
  imports = [
  ];

  options = {
    dotnet.enable = mkEnableOption "Enable dotnet";
  };

  config = let
    dotnet = pkgs.dotnetCorePackages.dotnet_9.sdk;
  in
  mkIf config.dotnet.enable {
    home.packages = [ 
      dotnet
      pkgs.dotnetCorePackages.dotnet_9.aspnetcore
      pkgs.mono
      pkgs.android-studio
      pkgs.jetbrains.rider
      pkgs.azure-functions-core-tools
    ];
    home.sessionVariables = {
      DOTNET_PATH = "${dotnet}/bin/dotnet";
      DOTNET_ROOT = "${dotnet}/share/dotnet";
    };
  };
}
