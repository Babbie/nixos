{
  programs.nvf.settings.vim.languages = {
    enableExtraDiagnostics = true;
    enableFormat = true;
    enableTreesitter = true;
    nix = {
      enable = true;
      lsp.servers = ["nixd"];
    };
  };
}
