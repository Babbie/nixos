{
  programs.nvf.settings.vim = {
    binds = {
      hardtime-nvim = {
        enable = true;
        setupOpts = {
          disable_mouse = false;
        };
      };
      whichKey = {
        enable = true;
        register = {
          "<leader>t" = "Neotree";
        };
      };
    };
    keymaps = [
      {
        key = "<leader>tt";
        mode = "n";
        silent = true;
        action = ":Neotree toggle<CR>";
        desc = "Filesystem";
      }
      {
        key = "<leader>tb";
        mode = "n";
        silent = true;
        action = ":Neotree toggle buffers bottom<CR>";
        desc = "Buffers";
      }
      {
        key = "<leader>tg";
        mode = "n";
        silent = true;
        action = ":Neotree toggle git_status right<CR>";
        desc = "Git";
      }
    ];
  };
}
