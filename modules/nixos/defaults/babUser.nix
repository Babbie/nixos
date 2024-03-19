{ lib, config, pkgs, ... }:

with lib; {
  imports = [
  ];

  options = {
    babUser.enable = mkOption {
      default = true;
      description = "Enable bab user module";
    };
    babUser.packages = mkOption {
      default = [ ];
      type = with types; listOf package;
      description = "List of user packages to install for bab";
    };
    babUser.extraGroups = mkOption {
      default = [ "networkmanager" "wheel" ];
      type = with types; listOf str;
      description = "List of groups";
    };
  };

  config = mkIf config.babUser.enable {
    programs.zsh.enable = true;
    users.users.bab = {
      isNormalUser = true;
      initialPassword = "12345";
      description = "Main user";
      extraGroups = config.babUser.extraGroups;
      shell = pkgs.zsh;
      packages = config.babUser.packages;
    };
    services.getty.autologinUser = "bab";
  };
}
