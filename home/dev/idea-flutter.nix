{ options, config, lib, inputs, pkgs, ... }:

with lib;
let 
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    platformVersions = [
      "36"
    ];
    systemImageTypes = [
      "google_apis_playstore"
    ];
    abiVersions = [
      "x86_64"
    ];
    includeSystemImages = true;
    includeEmulator = true;
  };

  idea-fhs = pkgs.buildFHSEnv {
    name = "idea-fhs";
    targetPkgs = pkgs: with pkgs; [
      androidComposition.androidsdk
      jdk17
      libGL
      fvm
    ];
  };
  
  idea = pkgs.jetbrains.idea-ultimate.overrideAttrs (attrs: {
    postInstall = ''
      # wrap idea in custom fhs
      mv $out/bin/idea-ultimate $out/bin/.idea-unwrapped

      cat >$out/bin/idea-ultimate <<EOL
      #!${pkgs.bash}/bin/bash
      ${idea-fhs}/bin/idea-fhs $out/bin/.idea-unwrapped "\$@"
      EOL

      chmod +x $out/bin/idea-ultimate
    '' + attrs.postInstall or "";
  });
in {
  home.packages = with pkgs; [ 
    idea 
    androidComposition.androidsdk
  ];
}
