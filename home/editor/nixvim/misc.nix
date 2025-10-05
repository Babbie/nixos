{
  programs.nixvim = {
    plugins = {
      bufferline.enable = true;
      cursorline.enable = true;
      indent-blankline.enable = true;
      intellitab.enable = true;
      undotree.enable = true;

      autoclose = {
        enable = true;
        settings = {
          options = {
            pair_spaces = true;
          };
        };
      };
      
      lualine = {
        enable = true;
        settings = {
          sections = {
            lualine_a = [ "mode" ];
            lualine_b = [ "branch" "diff" "diagnostics" ];
            lualine_c = [ "searchcount" ];
            lualine_x = [ "progress" "location" ];
            lualine_y = [ "lsp_status" ];
            lualine_z = [ "filetype" ];
          };
          options = {
            section_separators = {
              left = "";
              right = "";
            };
            component_separators = {
              left = "";
              right = "";
            };
          };
        };
      };
    };
    keymaps = [
      {
        key = "<leader>u";
        action = "<CMD>UndotreeToggle<CR>";
      }
    ];
  };
}
