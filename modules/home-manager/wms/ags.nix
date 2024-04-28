{ config, lib, pkgs, ... }:

with lib; {
  options = {
    ags.enable = mkEnableOption "Enable AGS (Aylur's GTK shell)";
  };

  config = mkIf config.ags.enable {
    home.packages = [ pkgs.ags pkgs.bun ];
    home.file.".config/ags" = {
      enable = true;
      source = ./ags;
    };
  };
}
