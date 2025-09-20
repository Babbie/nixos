{ lib, config, pkgs, ... }:

with lib; {
  imports = [
  ];

  options = {
    gnome-keyring.enable = mkOption {
      default = true;
      description = "Enable gnome-keyring";
    };
  };

  config = mkIf config.gnome-keyring.enable {
    services.gnome.gnome-keyring.enable = true;
  };
}
