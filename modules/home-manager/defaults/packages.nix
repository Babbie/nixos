{ lib, config, pkgs, ... }:

with lib; {
  imports = [
  ];

  options = {
    defaultHomePackages.enable = mkOption {
      default = true;
      description = "Enable default home packages";
    };
  };

  config = mkIf config.defaultHomePackages.enable {
    home.packages = with pkgs; [
      discord
      pavucontrol
      networkmanagerapplet
      thunar
    ];
    services.gvfs.enable = true;
  };
}
