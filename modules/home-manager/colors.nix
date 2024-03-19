{ lib, config, pkgs, nix-colors, ... }:

with lib; {
  imports = [
    nix-colors.homeManagerModules.default
  ];

  options = {
    colors.scheme = mkOption {
      default = nix-colors.colorSchemes.catppuccin-macchiato;
      description = "Set colorscheme";
    };
  };

  config = {
    colorScheme = config.colors.scheme;
  };
}
