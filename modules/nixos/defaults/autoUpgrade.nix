{ lib, config, rootPath, pkgs, inputs, ... }:

with lib; {
  imports = [
  ];

  options = {
    autoUpgrade.enable = mkOption {
      default = true;
      description = "Enable autoUpgrade";
    };
  };

  config = mkIf config.autoUpgrade.enable {
    system.autoUpgrade = {
      enable = true;
      flake = "path:${rootPath}";
      flags = [
        "-L"
        "--commit-lock-file"
      ];
      dates = "02:00";
      randomizedDelaySec = "45min";
    };
  };
}
