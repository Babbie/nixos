{ 
  lib,
  pkgs ? import <nixpkgs> {
    config.android_sdk.accept_license = true;
  },
  ...
}:

with lib;
let 
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    platformVersions = [
      "36"
      "35"
      "34"
      "33"
      "32"
      "31"
    ];
    buildToolsVersions = [
      "34.0.0"
    ];
    systemImageTypes = [
      "google_apis_playstore"
    ];
    abiVersions = [
      "x86_64"
    ];
    ndkVersions = [
      "28.2.13676358"
    ];
    cmakeVersions = [
      "3.22.1"
    ];
    includeSystemImages = true;
    includeEmulator = true;
    includeNDK = true;
    extraLicenses = [
      "android-googletv-license"
      "android-googlexr-license"
      "android-sdk-arm-dbt-license"
      "android-sdk-preview-license"
      "google-gdk-license"
      "mips-android-sysimage-license"
    ];
  };

  idea-fhs = pkgs.buildFHSEnv {
    name = "idea-fhs";
    targetPkgs = pkgs: with pkgs; [
      androidComposition.androidsdk
      jdk17
      libGL
      fvm
      cmake
      azure-cli
    ];
  };
  
  idea = pkgs.jetbrains.idea.overrideAttrs (attrs: {
    postInstall = ''
      # wrap idea in custom fhs
      mv $out/bin/idea $out/bin/.idea-unwrapped

      cat >$out/bin/idea <<EOL
      #!${getExe pkgs.bash}
      export ANDROID_HOME=/libexec/android-sdk
      ${getExe idea-fhs} $out/bin/.idea-unwrapped "\$@"
      EOL

      chmod +x $out/bin/idea
    '' + attrs.postInstall or "";
  });
in {
  home.packages = with pkgs; [ 
    idea 
    gnumake
  ];
}
