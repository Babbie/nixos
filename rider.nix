{ options, config, pkgs, lib, inputs, ... }:

with lib;
let 
  rider-fhs = pkgs.buildFHSEnv {
    name = "rider-fhs";
    runScript = "";
    targetPkgs = pkgs: with pkgs; [
      dotnet-sdk_9
      dotnet-aspnetcore_9
      dotnetPackages.Nuget
      mono
      msbuild
      ungoogled-chromium
    ];
  };
  
  rider = pkgs.jetbrains.rider.overrideAttrs (attrs: {
    postInstall = ''
      # wrap rider in custom fhs
      mv $out/bin/rider $out/bin/.rider-unwrapped

      cat >$out/bin/rider <<EOL
      #!${pkgs.bash}/bin/bash
      ${rider-fhs}/bin/rider-fhs $out/bin/.rider-unwrapped "\$@"
      EOL

      chmod +x $out/bin/rider
    '' + attrs.postInstall or "";
  });
in {
  environment.systemPackages = [ rider ];
}
