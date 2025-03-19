{
  programs.nixvim = {
    globals = {
      mapleader = " ";
    };

    # Keymaps
    keymaps = [
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

      # Open netrw Explore if Oil is not available
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Ex<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "Open netrw Explore";
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

	  # Open oil with leader e
	  {
	    key = "<leader>e";
	    action = "<CMD>Oil<CR>";
	    options = {
		  desc = "Open Oil";
		  silent = true;
	    };
      }

      # Toggle tagbar
      {
        mode = "n";
        key = "<C-g>";
        action = ":TagbarToggle<cr>";
        options.silent = true;
      }

    ];
  };
}
