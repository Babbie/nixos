{
  programs.nixvim = {
    lsp = {
      inlayHints.enable = true;
      keymaps = [
        {
          key = "<leader>do";
          action = "<CMD>lua vim.diagnostic.open_float()<CR>";
        }
        {
          key = "<leader>df";
          lspBufAction = "code_action";
        }
        {
          key = "K";
          action = "<CMD>Lspsaga hover_doc<CR>";
        }
      ];
      servers = {
        nixd.enable = true;
      };
    };

    plugins =  {
      fidget.enable = true;
      lspsaga.enable = true;
      lspconfig.enable = true;
      web-devicons.enable = true;
    };
    extraConfigLua =
    #lua
    ''
      vim.diagnostic.config({
        virtual_text = true,
      })
    '';
  };
}
