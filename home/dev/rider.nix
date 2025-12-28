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
      nodejs
      azure-cli
    ];
  };
  
  rider = pkgs.jetbrains.rider.overrideAttrs (attrs: {
    postInstall = ''
      # wrap rider in custom fhs
      mv $out/bin/rider $out/bin/.rider-unwrapped

      cat >$out/bin/rider <<EOL
      #!${getExe pkgs.bash}
      ${getExe rider-fhs} $out/bin/.rider-unwrapped "\$@"
      EOL

      chmod +x $out/bin/rider
    '' + attrs.postInstall or "";
  });
in {
  home.packages = [ rider ];
}
