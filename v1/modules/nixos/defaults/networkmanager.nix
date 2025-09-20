{ lib, config, pkgs, ... }:

with lib; {
  imports = [
  ];

  options = {
    networkmanager.enable = mkOption {
      default = true;
      description = "Enable NetworkManager";
    };
  };

  config = mkIf config.networkmanager.enable {
    networking.networkmanager.enable = true;
  };
}
