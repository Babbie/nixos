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
    packages = [ 
      dotnet
      pkgs.android-studio
      pkgs.jetbrains.rider.overrideAttrs (attrs: {
        postInstall = ''
          mv $out/bin/rider $out/bin/.rider-toolless
          makeWrapper $out/bin/.rider-toolless $out/bin/rider \
            --argv0 rider \
            --prefix PATH : "${makeBinPath [ dotnet pkgs.dotnetPackages.Nuget pkgs.mono pkgs.msbuild ]}"
        '' + attrs.postInstall or "";
      })
    ];
    sessionVariables = {
      DOTNET_PATH = "${dotnet}/bin/dotnet";
      DOTNET_ROOT = "${dotnet}/share/dotnet";
    };
  };
}
