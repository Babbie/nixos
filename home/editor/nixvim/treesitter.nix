{ pkgs, ... }:
{
  home.packages = [
    pkgs.tree-sitter
  ];
  programs.nixvim = {
    plugins = {
      treesitter.enable = true;
      twilight.enable = true;
    };
  };
}
