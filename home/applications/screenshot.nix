{ pkgs, ... }:
{
  home.packages = with pkgs; [
    grim
    slurp
    libnotify
    wl-clipboard
    wayfreeze
  ];

  home.file.".bin/screenshot" = {
    source = ./screenshot.sh;
    executable = true;
  };
  home.sessionPath = [ "$HOME/.bin" ];
}
