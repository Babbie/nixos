{
  programs.nixvim = {
    lsp = {
      inlayHints.enable = true;
      keymaps = [
        {
          key = "<leader>dn";
          action = "<CMD>Lspsaga diagnostic_jump_next<CR>";
        }
        {
          key = "<leader>dp";
          action = "<CMD>Lspsaga diagnostic_jump_prev<CR>";
        }
        {
          key = "<leader>df";
          action = "<CMD>Lspsaga finder<CR>";
        }
        {
          key = "<leader>dr";
          action = "<CMD>Lspsaga rename<CR>";
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
      lspconfig.enable = true;
      web-devicons.enable = true;
      lspsaga = {
        enable = true;
        settings = {
          beacon.enable = false;
          scroll_preview = {
            scroll_down = [ "<leader>dj" ];
            scroll_up = [ "<leader>dk" ];
          };
        };
      };
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
