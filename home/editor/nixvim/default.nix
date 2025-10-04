{
  imports = [
    ./lsp.nix
    ./treesitter.nix
    ./cmp.nix
  ];
  
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    colorscheme = "catppuccin-macchiato";
    colorschemes.catppuccin.enable = true;

    editorconfig.enable = true;

    globals.mapleader = " ";

    opts = {
      autoindent = true;
      colorcolumn = "120";
      copyindent = true;
      cursorline = true;
      expandtab = true;
      ignorecase = true;
      infercase = true;
      mousefocus = true;
      number = true;
      relativenumber = true;
      scrolloff = 4;
      shiftwidth = 2;
      sidescrolloff = 4;
      smartcase = true;
      smartindent = true;
      softtabstop = 2;
      undofile = true;
    };
  };
}
