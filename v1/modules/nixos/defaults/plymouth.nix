{ lib, config, pkgs, ... }:

with lib; {
  imports = [
  ];

  options = {
    plymouth.enable = mkOption {
      default = true;
      description = "Enable plymouth module";
    };
    plymouth.quiet = mkOption {
      default = true;
      description = "Add quiet to the kernel params";
    };
  };

  config = mkIf config.plymouth.enable {
    boot.plymouth.enable = true;
    boot.kernelParams = mkIf config.plymouth.quiet [ "quiet" ];
  };
}
