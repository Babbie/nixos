{ lib, pkgs, ... }:
{
  programs.github-copilot-cli = {
    enable = true;
    package = pkgs.github-copilot-cli.overrideAttrs (attrs: {
      postPatch = (attrs.postPatch or "") + ''
        (
          shopt -s globstar
          substituteInPlace **/*.js \
            --replace-quiet /bin/bash ${lib.getExe pkgs.bash}
        )
      '';
    });
    settings = {
      model = "auto";
    };
  };
}
