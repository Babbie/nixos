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
      vesktop
      pavucontrol
      networkmanagerapplet
      xfce.thunar
      inkscape-with-extensions
      spotify
      gtk4.dev
    ];
  };
}
