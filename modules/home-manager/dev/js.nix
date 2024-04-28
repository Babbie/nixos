{ lib, config, pkgs, ... }:

with lib; {
  imports = [
  ];

  options = {
    jsDev.enable = mkEnableOption "Enable js/ts dev environment";
  };

  config = mkIf config.jsDev.enable {
    home.packages = with pkgs; [
      lunarvim
      nodejs
      yarn
    ];
  };
}
