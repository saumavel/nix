{
  programs.nixvim = {
    plugins.which-key = {
      enable = true;
      registrations = {
        # Lazy plugin manager
        "<leader>L" = {
          command = "<cmd>Lazy<cr>";
          description = "Lazy";
        };

        # Find group
        "<leader>f" = {
          name = "Find";
        };

        # Diagnostics group and commands
        "<leader>d" = {
          name = "Diagnostics";
        };
        "<leader>dT" = {
          command = "<cmd>TodoTrouble<cr>";
          description = "open Todo comments in Trouble";
        };
        "<leader>dn" = {
          command = "<cmd>lua vim.diagnostic.goto_next()<cr>";
          description = "go to next diagnostic";
        };
        "<leader>dp" = {
          command = "<cmd>lua vim.diagnostic.goto_prev()<cr>";
          description = "go to previous diagnostic";
        };

        # Surround group
        "s" = {
          name = "Surround";
        };

        # Git group and commands
        "<leader>g" = {
          name = "Git";
        };
        "<leader>gb" = {
          command = "<cmd>Gitsigns toggle_current_line_blame<cr>";
          description = "Toggle line blame";
        };

        # Settings group and commands
        "<leader>." = {
          name = "Settings";
        };
        "<leader>.s" = {
          command = "<cmd>nohlsearch<cr>";
          description = "hide search highlight";
        };
      };
    };
  };
}
