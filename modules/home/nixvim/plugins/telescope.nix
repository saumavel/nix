{
  programs.nixvim = {
    plugins.telescope = {
      # Enable the Telescope fuzzy finder plugin
      # Telescope is a highly extendable fuzzy finder over lists
      # https://github.com/nvim-telescope/telescope.nvim
      enable = true;

      settings.defaults = {
        # Patterns to ignore when searching files
        # These will be completely excluded from file searches
        file_ignore_patterns = [
          "^.git/"           # Git directories - prevents searching through Git internals
          "^.mypy_cache/"    # MyPy cache directories for Python type checking
          "^__pycache__/"    # Python bytecode cache directories
          "^output/"         # Generic output directories
          "^data/"           # Data directories that might contain large files
          "%.ipynb"          # Jupyter notebook files (can be large and noisy in searches)
        ];
        
        # Environment variables for Telescope
        set_env = {
          COLORTERM = "truecolor";  # Ensure Telescope uses full color support for better UI rendering
        };
        
        # Custom keymappings for Telescope
        # This allows using Ctrl+j and Ctrl+k for navigation in addition to arrow keys
        mappings = {
          i = {  # Insert mode mappings
            # Navigation in results
            "<C-j>" = "move_selection_next";     # Move to next item with Ctrl+j
            "<C-k>" = "move_selection_previous"; # Move to previous item with Ctrl+k
            
            # You can add more mappings here if needed
            "<C-n>" = "move_selection_next";     # Alternative navigation with Ctrl+n
            "<C-p>" = "move_selection_previous"; # Alternative navigation with Ctrl+p
            
            # History navigation
            "<C-Down>" = "cycle_history_next";   # Next search in history
            "<C-Up>" = "cycle_history_prev";     # Previous search in history
            
            # Other useful mappings
            "<C-c>" = "close";                   # Close telescope
            "<C-u>" = "preview_scrolling_up";    # Scroll preview up
            "<C-d>" = "preview_scrolling_down";  # Scroll preview down
          };
          n = {  # Normal mode mappings
            # Navigation in results
            "<C-j>" = "move_selection_next";     # Move to next item with Ctrl+j
            "<C-k>" = "move_selection_previous"; # Move to previous item with Ctrl+k
            
            # Other useful mappings
            "q" = "close";                       # Close with q key
            "<C-c>" = "close";                   # Close with Ctrl+c
            
            # Preview scrolling
            "<C-u>" = "preview_scrolling_up";    # Scroll preview up
            "<C-d>" = "preview_scrolling_down";  # Scroll preview down
          };
        };
      };
    };
    keymaps = [
      #---------------------------------------------------------------------------
      # TELESCOPE KEYBINDINGS
      #---------------------------------------------------------------------------

      # File navigation
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "Find files";
        };
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "Find with grep";
        };
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "Find buffers";
        };
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = "<cmd>Telescope oldfiles<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "Find recent files";
        };
      }

      # Navigation helpers
      {
        mode = "n";
        key = "<leader>fh";
        action = "<cmd>Telescope help_tags<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "Find help tags";
        };
      }
      {
        mode = "n";
        key = "<leader>fm";
        action = "<cmd>Telescope marks<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "Find marks";
        };
      }
      {
        mode = "n";
        key = "<leader>fc";
        action = "<cmd>Telescope commands<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "Find commands";
        };
      }
      {
        mode = "n";
        key = "<leader>fk";
        action = "<cmd>Telescope keymaps<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "Find keymaps";
        };
      }

      # Git operations
      {
        mode = "n";
        key = "<leader>gs";
        action = "<cmd>Telescope git_status<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "Git status";
        };
      }
      {
        mode = "n";
        key = "<leader>gc";
        action = "<cmd>Telescope git_commits<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "Git commits";
        };
      }

      # Current buffer operations
      {
        mode = "n";
        key = "<leader>/";
        action = "<cmd>Telescope current_buffer_fuzzy_find<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "Fuzzy find in current buffer";
        };
      }

      # Additional Telescope functionality
      {
        mode = "n";
        key = "<leader>u";
        action = ":Telescope undo<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Undo tree";
        };
      }
    ];
  };
}
