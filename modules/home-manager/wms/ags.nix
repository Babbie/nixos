{ config, lib, pkgs, ... }:

with lib; {
  options = {
    ags.enable = mkEnableOption "Enable AGS (Aylur's GTK shell)";
  };

  config = mkIf config.ags.enable {
    home.packages = [ pkgs.ags pkgs.bun ];
    xdg.configFile."ags" = {
      enable = false;
      source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/nixos/modules/home-manager/wms/ags";
    };
  };
}
