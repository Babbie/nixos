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
          lspBufAction = "hover";
        }
      ];
      servers = {
        nixd.enable = true;
      };
    };

    plugins =  {
      fidget.enable = true;
      lspconfig.enable = true;
      cmp = {
        autoEnableSources = true;
        settings.sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
      };
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
