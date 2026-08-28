{ options, config, pkgs, lib, inputs, ... }:

with lib;
let 
  rider-fhs = pkgs.buildFHSEnv {
    name = "rider-fhs";
    runScript = "";
    targetPkgs = pkgs: with pkgs; [
      dotnet-sdk_10
      dotnet-aspnetcore_10
      dotnetPackages.Nuget
      dotnet-ef
      mono
      msbuild
      ungoogled-chromium
      nodejs
      git
      azure-cli
      azurite
      icu
      openssl
    ];
  };

  copilot-plugin = pkgs.stdenv.mkDerivation {
    name = "github-copilot-intellij";
    src = pkgs.fetchzip {
      url = "https://plugins.jetbrains.com/files/17718/1118437/github-copilot-intellij-1.14.2-261-linux-x64.zip";
      hash = "sha256-piQttnhy9bvwwNJ5v5kuwqXNe4aeC44CLnyTIk/UTVo=";
    };
    dontBuild = true;
    dontStrip = true;
    dontPatchShebangs = true;
    installPhase = ''
      cp -r . $out
      chmod +x $out/copilot-agent/native/linux-x64/copilot-language-server
    '';
  };

  rider-base = pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.rider [ copilot-plugin ];

  rider = rider-base.overrideAttrs (attrs: {
    postFixup = (attrs.postFixup or "") + ''
      mv $out/bin/rider $out/bin/.rider-unwrapped

      cat >$out/bin/rider <<EOL
      #!${getExe pkgs.bash}
      ${getExe rider-fhs} $out/bin/.rider-unwrapped "\$@"
      EOL

      chmod +x $out/bin/rider
    '';
  });
in {
  home.packages = [ rider ];
}
