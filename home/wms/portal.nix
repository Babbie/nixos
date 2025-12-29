{ pkgs, ... }:
{
  xdg.autostart.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = "wlr;gtk";
        "org.freedesktop.impl.portal.ScreenCast" = "wlr";
      };
    };
  };
}
