{ config, lib, ... }:

with lib; {
  options = {
    ags.enable = mkEnableOption "Enable AGS (Aylur's GTK shell)";
  };

  config = mkIf config.ags.enable {
    home.packages = [ ags ];
  };
}
