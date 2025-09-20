{ lib, config, pkgs, ... }:

with lib; {
  imports = [
  ];

  options = {
    userSsh.enable = mkOption {
      default = true;
      description = "Enable default ssh settings";
    };
    userSsh.matchBlocks = mkOption {
      default = {
        "wilhelm" = {
          hostname = "10.0.0.100";
          port = 49999;
        };
      };
    };
  };

  config = mkIf config.userSsh.enable {
    programs.ssh = {
      enable = true;
      matchBlocks = config.userSsh.matchBlocks;
    };
  };
}
