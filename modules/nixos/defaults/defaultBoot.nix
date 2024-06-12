{ lib, config, pkgs, ... }:

with lib; {
  imports = [
  ];

  options = {
    defaultBoot.enable = mkOption {
      default = true;
      description = "Enable default boot settings module";
    };
    defaultBoot.timeout = mkOption {
      default = 0;
      description = "Boot timeout";
    };
  };

  config = mkIf config.defaultBoot.enable {
    boot.loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
        configurationLimit = 8;
      };
      efi.canTouchEfiVariables = true;
      timeout = config.defaultBoot.timeout;
    };

    boot.initrd.systemd.enable = true;
  };
}
