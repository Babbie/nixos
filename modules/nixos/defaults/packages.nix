{ lib, config, pkgs, ... }:

with lib; {
  imports = [
  ];

  options = {
    defaultPackages.enable = mkOption {
      default = true;
      description = "Enable default packages";
    };
  };

  config = mkIf config.defaultPackages.enable {
    environment.systemPackages = with pkgs; [
      neovim
      curl
      polkit_gnome
    ];
  };
}
