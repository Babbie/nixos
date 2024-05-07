{ lib, config, pkgs, ... }:

with lib; {
  imports = [
  ];

  options = {
    miscDefaults.enable = mkOption {
      default = true;
      description = "Enable misc NixOS setting defaults";
    };
  };

  config = mkIf config.miscDefaults.enable {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.gc = {
      automatic = true;
      persistent = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
      randomizedDelaySec = "1h";
    };
    programs.dconf.enable = true;
    nixpkgs.config.allowUnfree = true;
    home-manager.useGlobalPkgs = true;
    hardware.opengl.enable = true;
    fonts.enableDefaultPackages = true;
    security.polkit.enable = true;
    services.gvfs.enable = true;
  };
}
