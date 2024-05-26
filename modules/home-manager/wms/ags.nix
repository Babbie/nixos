{ config, lib, pkgs, rootPath, ... }:

with lib; {
  options = {
    ags.enable = mkEnableOption "Enable AGS (Aylur's GTK shell)";
  };

  config = mkIf config.ags.enable {
    home.packages = [ pkgs.ags pkgs.bun ];
    xdg.configFile."ags" = {
      enable = true;
      source = config.lib.file.mkOutOfStoreSymlink ./ags;
    };
  };
}
