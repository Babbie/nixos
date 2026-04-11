{ inputs, lib, pkgs, ... }:

{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    inputs.nix-index-database.homeModules.default
    inputs.nixvim.homeModules.nixvim
    inputs.zen-browser.homeModules.beta

    ../../home/applications
    ../../home/editor/nixvim
    ../../home/shell
    ../../home/wms/mango
    ../../home/secretService
  ];

  config = with lib; {
    home.username = mkDefault "bab";
    home.homeDirectory = mkDefault "/home/bab";

    # Packages that should be installed to the user profile.
    home.packages = with pkgs; [
      unzip
    ];

    home.file."Pictures/Wallpapers" = {
      source = ../../files/wallpapers;
      recursive = true;
    };

    catppuccin = {
      enable = mkDefault true;
      accent = mkDefault "blue";
      flavor = mkDefault "macchiato";
    };

    programs.git.enable = true;
    programs.zen-browser.enable = mkDefault true;
  };
}
