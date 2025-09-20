{ lib, config, pkgs, ... }:

with lib; {
  options = {
    customSudo.enable = mkOption {
      default = true;
      description = "Enable sudo customization";
    };
    customSudo.envKeep = mkOption {
      default = [ "HOME" "EDITOR" "SUDO_EDITOR" "VISUAL" ];
      description = "List of env variables to keep when using sudo";
    };
    customSudo.insults = mkOption {
      default = true;
      description = "Turn on sudo insults";
    };
  };

  config = mkIf config.customSudo.enable {
    nixpkgs.overlays = mkIf config.customSudo.insults [ (final: prev: { sudo = prev.sudo.override { withInsults = true; }; }) ];
    security.sudo.configFile = mkMerge [
      "Defaults env_keep += \"${builtins.concatStringsSep " " config.customSudo.envKeep}\""
      (mkIf config.customSudo.insults "\nDefaults insults")
    ];
  };
}
