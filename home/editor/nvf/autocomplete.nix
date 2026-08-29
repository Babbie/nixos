{
  programs.ripgrep.enable = true;
  programs.nvf.settings.vim.autocomplete.blink-cmp = {
    enable = true;
    setupOpts.signature.enabled = true;
    setupOpts.sources.default = [
      "lsp"
      "path"
      "snippets"
      "buffer"
    ];
    sourcePlugins = {
      emoji.enable = true;
      ripgrep.enable = true;
      spell.enable = true;
    };
  };
}
