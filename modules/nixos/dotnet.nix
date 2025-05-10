{ lib, config, pkgs, ... }:

with lib; {
  imports = [
  ];

  options = {
    dotnet.enable = mkEnableOption "Enable dotnet";
  };

  config = mkIf config.dotnet.enable {
    let
      dotnet = pkgs.dotnetCorePackages.dotnet_9.sdk;
    in
    pkgs.mkShell {
      packages = [ dotnet ];
      sessionVariables = {
        DOTNET_PATH = "${dotnet}/bin/dotnet";
        DOTNET_ROOT = "${dotnet}/share/dotnet";
      };
    };
  };
}
