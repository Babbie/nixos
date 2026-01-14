{ pkgs, config, ... }:
{
  home.pointerCursor = {
    enable = true;
    package = pkgs.posy-cursors;
    name = "Posy_Cursor_Black";
    x11.enable = true;
    gtk.enable = true;
    dotIcons.enable = true;
    hyprcursor.enable = true;
    sway.enable = true;
  };
  home.sessionVariables = {
    XCURSOR_THEME = config.home.pointerCursor.name;
    XCURSOR_SIZE = config.home.pointerCursor.size;
  };
}
