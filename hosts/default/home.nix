{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    inputs.nix-index-database.homeModules.default
    inputs.zen-browser.homeModules.beta

    ../../home/applications
    #../../home/editor/nixvim
    ../../home/editor
    ../../home/shell
    ../../home/wms/mango
    ../../home/secretService
  ];

  config = with lib; {
    home = {
      username = mkDefault "bab";
      homeDirectory = mkDefault "/home/bab";
      packages = with pkgs; [
        unzip
      ];
      file."Pictures/Wallpapers" = {
        source = ../../files/wallpapers;
        recursive = true;
      };
    };

    catppuccin = rec {
      enable = mkDefault true;
      autoEnable = enable;
      accent = mkDefault "blue";
      flavor = mkDefault "macchiato";
    };

    programs.git.enable = true;
    programs.zen-browser.enable = mkDefault true;
  };
}
