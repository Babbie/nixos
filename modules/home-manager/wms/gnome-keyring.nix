{ config, lib, pkgs, home, ... }:

with lib; {
  options = {
    gnome-keyring.enable = mkEnableOption "Gnome keyring";
  };

  config = mkIf config.gnome-keyring.enable {
    xdg.portal.config.common."org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
    services.gnome-keyring.enable = true;
    home.packages = [ pkgs.gnome.seahorse ];
  };
}
