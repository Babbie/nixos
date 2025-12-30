{ pkgs, ... }:
{
  home.packages = with pkgs; [
    grim
    slurp
    libnotify
    wl-clipboard
  ];

  home.file.".bin/screenshot" = {
    source = ./screenshot.sh;
    executable = true;
  };
  home.sessionPath = [ "$HOME/.bin" ];
}
