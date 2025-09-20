{ lib, config, pkgs, ... }:

with lib; {
  imports = [
  ];

  options = {
    azureDev.enable = mkEnableOption "Enable azure dev environment";
  };

  config = mkIf config.azureDev.enable {
    home.packages = with pkgs; [
      vimPlugins.nvim-treesitter.withAllGrammars
      lunarvim
      vscode-langservers-extracted
      jq
      azure-cli
    ];
  };
}
