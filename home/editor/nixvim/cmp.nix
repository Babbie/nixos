{ pkgs, ... }:
{
  programs.ripgrep.enable = true;
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      blink-ripgrep-nvim
    ];
    plugins = {
      blink-cmp-dictionary.enable = true;
      blink-cmp-spell.enable = true;
      blink-emoji.enable = true;
      blink-ripgrep.enable = true;

      blink-cmp = {
        enable = true;
        setupLspCapabilities = true;

        settings = {
          keymap = {
            "<C-space>" = [
              "show"
              "show_documentation"
              "hide_documentation"
            ];
            "<CR>" = [
              "accept"
              "fallback"
            ];
            "<Tab>" = [
              "select_next"
              "snippet_forward"
              "fallback"
            ];
            "<S-Tab>" = [
              "select_prev"
              "snippet_backward"
              "fallback"
            ];
            "<Up>" = [
              "select_prev"
              "fallback"
            ];
            "<Down>" = [
              "select_next"
              "fallback"
            ];
            "<C-p>" = [
              "select_prev"
              "fallback"
            ];
            "<C-n>" = [
              "select_next"
              "fallback"
            ];
            "<C-up>" = [
              "scroll_documentation_up"
              "fallback"
            ];
            "<C-down>" = [
              "scroll_documentation_down"
              "fallback"
            ];
          };

          signature.enabled = true;

          sources = {
            default = [
              "buffer"
              "lsp"
              "path"
              "snippets"
              # Community
              "emoji"
              "spell"
              "ripgrep"
            ];
            providers = {
              ripgrep = {
                name = "Ripgrep";
                module = "blink-ripgrep";
                score_offset = 1;
              };
              emoji = {
                name = "Emoji";
                module = "blink-emoji";
                score_offset = 1;
              };
              lsp.score_offset = 4;
              spell = {
                name = "Spell";
                module = "blink-cmp-spell";
                score_offset = 1;
              };
            };
          };
        };
      };
    };
  };
}
