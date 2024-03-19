{ lib, config, pkgs, ... }:

with lib; {
  imports = [
  ];

  options = {
    bluetooth.enable = mkOption {
      default = true;
      description = "Enable bluetooth";
    };
  };

  config = mkIf config.bluetooth.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;
  };
}
