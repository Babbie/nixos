{ config, lib, pkgs, home, ... }:

with lib; {
  options = {
    gtkConfig.enable = mkOption {
      default = true;
      description = "Enable default GTK settings";
    };
  };

  config = mkIf config.gtkConfig.enable {
    fonts.fontconfig.enable = true;
    home.packages = [ pkgs.fira ];
    gtk = {
      enable = true;
      font.name = "Fira Sans 11";
      theme = { 
        name = "Catppuccin-Macchiato-Standard-Green-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "green" ];
          tweaks = [ "rimless" ];
          variant = "macchiato";
        };
      };
      # cursorTheme = {
      #   name = "Catppuccin-Macchiato-Dark-Cursors";
      #   package = pkgs.catppuccin-cursors.macchiatoDark;
      #   size = 32;
      # };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.catppuccin-papirus-folders.override {
          flavor = "macchiato";
          accent = "green";
        };
      };
    };
    xdg.configFile = {
      "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
      "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
      "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
    };
    home.pointerCursor = {
      gtk.enable = true;
      name = "catppuccin-macchiato-dark-cursors";
      package = pkgs.catppuccin-cursors.macchiatoDark;
      size = 32;
    };
  };
}
