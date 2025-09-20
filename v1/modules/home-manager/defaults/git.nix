{ lib, config, pkgs, ... }:

with lib; {
  imports = [
  ];

  options = {
    git.enable = mkOption {
      default = true;
      description = "Enable default home packages";
    };
  };

  config = mkIf config.git.enable {
    programs.bat.enable = true;
    programs.btop.enable = true;
    programs.git = {
      enable = true;
      userEmail = "bab@bab.cloud";
      userName = "Babbie";
    };
  };
}
