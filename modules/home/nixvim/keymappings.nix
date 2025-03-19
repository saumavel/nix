{
  programs.nixvim = {
    globals = {
      mapleader = " ";  # Set space as the leader key
    };

    # Keymaps organized by functionality
    keymaps = [
      #---------------------------------------------------------------------------
      # FILE OPERATIONS
      #---------------------------------------------------------------------------
      
      # Update file
      {
        mode = "n";
        key = "<leader>w";
        action = "<cmd>up<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "Update file";
        };
      }
      
      # Update and close nvim
      {
        mode = "n";
        key = "<leader>x";
        action = "<cmd>x<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "Update and close nvim";
        };
      }
      
      # Close nvim
      {
        mode = "n";
        key = "<leader>q";
        action = "<cmd>q<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "Close nvim";
        };
      }
      
      # Close nvim with force
      {
        mode = "n";
        key = "<leader>!";
        action = "<cmd>q!<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "Close nvim with force";
        };
      }

      # Vertical Split
      {
        mode = "n";
        key = "<leader>s";
        action = ":vsplit<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Vertical Split";
        };
      }

      #---------------------------------------------------------------------------
      # WINDOW NAVIGATION
      #---------------------------------------------------------------------------
      
      # Normal and visual mode window navigation
      {
        mode = ["n" "v"];
        key = "<C-h>";
        action = "<C-w>h";
        options = {
          silent = true;
          noremap = true;
          desc = "Move to the pane on the left";
        };
      }
      {
        mode = ["n" "v"];
        key = "<C-j>";
        action = "<C-w>j";
        options = {
          silent = true;
          noremap = true;
          desc = "Move to the pane below";
        };
      }
      {
        mode = ["n" "v"];
        key = "<C-k>";
        action = "<C-w>k";
        options = {
          silent = true;
          noremap = true;
          desc = "Move to the pane above";
        };
      }
      {
        mode = ["n" "v"];
        key = "<C-l>";
        action = "<C-w>l";
        options = {
          silent = true;
          noremap = true;
          desc = "Move to the pane on the right";
        };
      }
      
      # Terminal and insert mode window navigation
      {
        mode = ["t" "i"];
        key = "<C-h>";
        action = "<C-\\><C-N><C-w>h";
        options = {
          silent = true;
          noremap = true;
          desc = "Move to the pane on the left (terminal/insert)";
        };
      }
      {
        mode = ["t" "i"];
        key = "<C-j>";
        action = "<C-\\><C-N><C-w>j";
        options = {
          silent = true;
          noremap = true;
          desc = "Move to the pane below (terminal/insert)";
        };
      }
      {
        mode = ["t" "i"];
        key = "<C-k>";
        action = "<C-\\><C-N><C-w>k";
        options = {
          silent = true;
          noremap = true;
          desc = "Move to the pane above (terminal/insert)";
        };
      }
      {
        mode = ["t" "i"];
        key = "<C-l>";
        action = "<C-\\><C-N><C-w>l";
        options = {
          silent = true;
          noremap = true;
          desc = "Move to the pane on the right (terminal/insert)";
        };
      }
      
      # Exit terminal mode with Escape
      {
        mode = "t";
        key = "<Esc>";
        action = "<C-\\><C-n>";
        options = {
          silent = true;
          noremap = true;
          desc = "Exit terminal mode";
        };
      }

      #---------------------------------------------------------------------------
      # BUFFER NAVIGATION
      #---------------------------------------------------------------------------
      
      # Navigate between buffers
      {
        mode = "n";
        key = "<Tab>";
        action = ":BufferNext<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Next buffer";
        };
      }
      {
        mode = "n";
        key = "<S-Tab>";
        action = ":BufferPrevious<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Prev buffer";
        };
      }

      #---------------------------------------------------------------------------
      # MOVEMENT AND NAVIGATION
      #---------------------------------------------------------------------------
      
      # Better start and end of line
      {
        mode = ["n" "v"];
        key = "H";
        action = "^";
        options = {
          silent = true;
          noremap = true;
          desc = "Start of the line";
        };
      }
      {
        mode = ["n" "v"];
        key = "L";
        action = "$";
        options = {
          silent = true;
          noremap = true;
          desc = "End of the line";
        };
      }
      
      # Faster movement
      {
        mode = "n";
        key = "J";
        action = "6j";
        options = {
          silent = true;
          noremap = true;
          desc = "6 lines down";
        };
      }
      {
        mode = "n";
        key = "K";
        action = "6k";
        options = {
          silent = true;
          noremap = true;
          desc = "6 lines up";
        };
      }

      # Preserve default functionality
      {
        mode = "n";
        key = "q";
        action = "q";
        options = {
          silent = true;
          noremap = true;
          desc = "Recording macros";
        };
      }
      {
        mode = "n";
        key = "<C-v>";
        action = "<C-v>";
        options = {
          silent = true;
          noremap = true;
          desc = "Block visual mode";
        };
      }

      #---------------------------------------------------------------------------
      # CLIPBOARD AND REGISTER OPERATIONS
      #---------------------------------------------------------------------------
      
      # System clipboard operations
      {
        mode = ["n" "v"];
        key = "<leader>y";
        action = "\"+y";
        options = {
          silent = true;
          noremap = true;
          desc = "System clipboard yank";
        };
      }
      {
        mode = ["n" "v"];
        key = "<leader>Y";
        action = "\"+Y";
        options = {
          silent = true;
          noremap = true;
          desc = "System clipboard Yank";
        };
      }
      {
        mode = ["n" "v"];
        key = "<leader>p";
        action = "\"+]p";
        options = {
          silent = true;
          noremap = true;
          desc = "System clipboard put & indent";
        };
      }
      {
        mode = ["n" "v"];
        key = "<leader>P";
        action = "\"+]P";
        options = {
          silent = true;
          noremap = true;
          desc = "System clipboard Put & indent";
        };
      }
      
      # Normal put with correct indent
      {
        mode = ["n" "v"];
        key = "p";
        action = "]p";
        options = {
          silent = true;
          noremap = true;
          desc = "put with indent";
        };
      }
      {
        mode = ["n" "v"];
        key = "P";
        action = "]P";
        options = {
          silent = true;
          noremap = true;
          desc = "Put with indent";
        };
      }
      
      # Keep yanked text after put in visual mode
      {
        mode = "x";
        key = "p";
        action = "\"_dP";
        options = {
          silent = true;
          noremap = true;
          desc = "Put without yanking replaced text";
        };
      }

      #---------------------------------------------------------------------------
      # FILE EXPLORER
      #---------------------------------------------------------------------------
      
      # Open Oil file explorer
      {
        mode = "n";  # Explicitly set normal mode
        key = "<leader>e";
        action = "<cmd>Oil<cr>";  # Use lowercase cmd for consistency
        options = {
          silent = true;
          noremap = true;  # Prevent further remapping
          desc = "Open Oil file explorer";
        };
      }

      # Add a fallback binding only if you want an alternative
      {
        mode = "n";
        key = "<leader>E";  # Use capital E for the fallback
        action = "<cmd>Explore<cr>";  # Use the full command name
        options = {
          silent = true;
          noremap = true;
          desc = "Open netrw Explore (fallback)";
        };
      }

      #---------------------------------------------------------------------------
      # PLUGIN SPECIFIC KEYBINDINGS
      #---------------------------------------------------------------------------
      
      # Toggle tagbar - code structure overview
      {
        mode = "n";
        key = "<C-g>";
        action = ":TagbarToggle<cr>";
        options = {
          silent = true;
          desc = "Toggle Tagbar";
        };
      }

      # Open trouble window
      {
        mode = "n";
        key = "<leader>t";
        action = ":Trouble<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Open trouble window";
        };
      }

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

      #---------------------------------------------------------------------------
      # DEBUGGING (DAP) KEYBINDINGS
      #---------------------------------------------------------------------------
      
      # Breakpoint management
      {
        mode = "n";
        key = "<leader>b";
        action = ":DapToggleBreakpoint<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Toggle breakpoint";
        };
      }
      {
        mode = "n";
        key = "<leader>B";
        action = ":DapClearBreakpoints<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Clear all breakpoints";
        };
      }
      
      # Debugging control
      {
        mode = "n";
        key = "<leader>dc";
        action = ":DapContinue<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Start/Continue debugging";
        };
      }
      {
        mode = "n";
        key = "<leader>dso";
        action = ":DapStepOver<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Step over";
        };
      }
      {
        mode = "n";
        key = "<leader>dsi";
        action = ":DapStepInto<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Step into";
        };
      }
      {
        mode = "n";
        key = "<leader>dsO";
        action = ":DapStepOut<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Step out";
        };
      }
      {
        mode = "n";
        key = "<leader>dr";
        action = "<cmd>lua require('dap').run_to_cursor()<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Run to cursor";
        };
      }
      
      # DAP UI and session management
      {
        mode = "n";
        key = "<leader>du";
        action = "<cmd>lua require('dapui').toggle()<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Toggle DAP UI";
        };
      }
      {
        mode = "n";
        key = "<leader>dR";
        action = "<cmd>lua require('dap').restart()<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Restart debugging session";
        };
      }
      {
        mode = "n";
        key = "<leader>dT";
        action = "<cmd>lua require('nvim-dap-virtual-text').refresh()<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Refresh DAP Virtual Text";
        };
      }
    ];
  };
}
