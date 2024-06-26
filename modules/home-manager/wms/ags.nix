{ config, lib, inputs, ... }:

with lib; {
  imports = [ inputs.ags.homeManagerModules.default ];
  
  options = {
    ags.enable = mkEnableOption "Enable AGS (Aylur's GTK shell)";
  };

  config = mkIf config.ags.enable {
    programs.ags = {
      enable = true;
      #configDir = ./ags;
    };
  };
}
