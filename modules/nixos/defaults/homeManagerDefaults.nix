{ lib, config, pkgs, inputs, nix-colors, ... }:

with lib; {
  imports = [
  ];

  options = {
    homeManagerDefaults.enable = mkOption {
      default = true;
      description = "Enable home-manager setting defaults";
    };
  };

  config = mkIf config.homeManagerDefaults.enable {
    home-manager = {
      useGlobalPkgs = true;
      extraSpecialArgs = { inherit inputs nix-colors; };
    };
  };
}
