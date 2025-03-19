{
  programs.nixvim = {
    plugins.oil = {
      # Enable Oil.nvim - a file explorer that lets you edit your filesystem like a buffer
      # Provides a more Vim-native way to browse and manipulate files
      enable = true;
      
      settings = {
        # Use Oil as the default file explorer instead of netrw
        # This replaces Vim's built-in explorer with Oil
        default_file_explorer = true;
        
        # Configure which columns to display in the Oil buffer
        columns = [
          "icon"  # Show file/directory icons for visual identification
        ];
        
        # Skip confirmation prompts for simple file operations
        # Reduces friction when performing common actions
        skip_confirm_for_simple_edits = true;
        
        # Prompt to save when selecting a new entry after making changes
        # Prevents accidental loss of edits to the Oil buffer
        prompt_save_on_select_new_entry = true;
        
        # Constrain cursor to only editable parts of the buffer
        # Prevents cursor from moving to non-interactive areas
        constrain_cursor = "editable";
        
        # Automatically update the Oil buffer when filesystem changes are detected
        # Keeps the view in sync with external changes
        watch_for_changes = true;
        
        # View options control how files are displayed
        view_options = {
          show_hidden = true;  # Show hidden files (dotfiles) by default
                              # Can be toggled with g. keybinding
        };
        
        # Custom keymaps for navigating and interacting with Oil
        keymaps = {
          # Help and navigation
          "g?" = "actions.show_help";            # Show help popup with available commands
          "l" = "actions.select";                # Open file/directory (move forward)
          "<Cr>" = "actions.select";             # Open file/directory with Enter key
          "h" = "actions.parent";                # Go to parent directory (move back)
          "-" = "actions.open_cwd";              # Open current working directory
          "~" = "actions.cd";                    # Change to home directory
          
          # Split operations
          "<C-s>" = {
            # Open in vertical split (side by side)
            __raw = ''{ "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" }'';
          };
          "<C-v>" = {
            # Open in horizontal split (stacked)
            __raw = ''{ "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" }'';
          };
          
          # View operations
          "<C-p>" = "actions.preview";           # Preview file without opening it
          "<C-c>" = "actions.close";             # Close Oil and return to previous buffer
          "<C-l>" = "actions.refresh";           # Manually refresh the directory listing
          
          # Display options
          "gs" = "actions.change_sort";          # Change sort order of files
          "gx" = "actions.open_external";        # Open file with external program
          "g." = "actions.toggle_hidden";        # Toggle display of hidden files
          "g\\" = "actions.toggle_trash";        # Toggle display of trash files
          
          # Integration with fzf-lua for fuzzy finding
          "<leader>ff" = {
            # Find files in current Oil directory using fzf
            __raw = ''
              function()
                require("fzf-lua").files({
                  cwd = require("oil").get_current_dir()
                })
              end
            '';
            mode = "n";                          # Normal mode keybinding
            nowait = true;                       # Don't wait for additional keystrokes
            desc = "Find files in the current directory";
          };
          "<leader>fj" = {
            # Grep in current Oil directory using fzf
            __raw = ''
              function()
                require("fzf-lua").live_grep({
                  cwd = require("oil").get_current_dir()
                })
              end
            '';
            mode = "n";                          # Normal mode keybinding
            nowait = true;                       # Don't wait for additional keystrokes
            desc = "Grep in the current directory";
          };
          
          # Custom PDF handling with Zathura
          "zp" = {
            # Open PDF files in Zathura PDF viewer
            __raw = ''
              function()
                local oil = require("oil")
                local name = oil.get_cursor_entry().name
                if name:match("%.pdf$") then
                  local path = oil.get_current_dir() .. name
                  vim.fn.jobstart(string.format("~/.local/bin/zathura-nix %s", vim.fn.shellescape(path)))
                end
              end
            '';
            desc = "Open PDF in Zathura";
          };
        };
        
        # Disable default keymaps to use only our custom ones
        # Prevents key conflicts and provides a cleaner, more controlled interface
        use_default_keymaps = false;
      };
    };
  };
}
