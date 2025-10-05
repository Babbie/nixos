{ inputs, lib, pkgs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
    inputs.zen-browser.homeModules.beta
    inputs.catppuccin.homeModules.catppuccin

    ../../home/applications
    ../../home/editor/nixvim
    ../../home/shell
  ];

  config = with lib; {
    home.username = mkDefault "bab";
    home.homeDirectory = mkDefault "/home/bab";

    # Packages that should be installed to the user profile.
    home.packages = with pkgs; [
    ];

    catppuccin = {
      enable = mkDefault true;
      accent = mkDefault "mauve";
      flavor = mkDefault "macchiato";
    };

    programs.git.enable = true;
    programs.zen-browser.enable = mkDefault true;
  };
}
