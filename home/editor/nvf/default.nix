{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.default

    ./autocomplete.nix
    ./binds.nix
    ./diagnostics.nix
    ./languages.nix
    ./lsp.nix
    ./telescope.nix
  ];

  home.packages = [pkgs.luaPackages.tree-sitter-cli];
  programs.nvf = {
    enable = true;
    settings.vim = {
      autopairs.nvim-autopairs.enable = true;
      bell = "on";
      clipboard = {
        enable = true;
        providers.wl-copy.enable = true;
        registers = "unnamed";
      };
      comments.comment-nvim.enable = true;
      filetree.neo-tree = {
        enable = true;
        setupOpts = {
          enable_cursor_hijack = true;
          git_status_async = true;
        };
      };
      git = {
        enable = true;
      };
      globals = {
        minimap_auto_start = 1;
        minimap_git_colors = 1;
      };
      minimap.minimap-vim.enable = true;
      options = {
        autoindent = true;
        cursorlineopt = "both";
        shiftwidth = 2;
        tabstop = 2;
      };
      searchCase = "smart";
      statusline.lualine = {
        enable = true;
        setupOpts = {
          component_separators = {
            left = "";
            right = "";
          };
          section_separators = {
            left = "";
            right = "";
          };

          sections = {
            lualine_a = [{"@1" = "mode";}];
            lualine_b = [{"@1" = "branch";} {"@1" = "diff";} {"@1" = "diagnostics";}];
            lualine_c = [{"@1" = "searchcount";}];
            lualine_x = [{"@1" = "progress";} {"@1" = "location";}];
            lualine_y = [{"@1" = "lsp_status";}];
            lualine_z = [{"@1" = "filetype";}];
          };
        };
      };
      syntaxHighlighting = true;
      tabline.nvimBufferline = {
        enable = true;
        mappings.closeCurrent = "<leader>bc";
        mappings.pick = "<leader>bk";
        setupOpts.options.numbers = "ordinal";
      };
      theme = {
        enable = true;
        name = "catppuccin";
        style = "macchiato";
      };
      undoFile.enable = true;
      viAlias = true;
      vimAlias = true;
      visuals = {
        blink-indent.enable = true;
        fidget-nvim.enable = true;
        nvim-cursorline = {
          enable = true;
          setupOpts = {
            cursorline.enable = true;
            cursorline.timeout = 0;
            cursorword.enable = true;
          };
        };
      };
    };
  };
}
