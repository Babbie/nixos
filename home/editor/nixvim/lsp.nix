{
  programs.nixvim = {
    lsp = {
      inlayHints.enable = true;
      servers = {
        nixd.enable = true;
        roslyn_ls.enable = true;
      };

      keymaps = [
        {
          key = "K";
          lspBufAction = "hover";
          mode = "n";
        }
      ];
    };

    plugins =  {
      fidget.enable = true;
      lspconfig.enable = true;
      web-devicons.enable = true;
    };

    extraConfigLua =
      #lua
      ''
      vim.diagnostic.config({
        virtual_text = true,
        severity_sort = true,
      })
      '';
  };
}
