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
          };  # Note the semicolon here, not a comma
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
        
        # Extension configurations
        extensions = {
          # TreeSitter integration for Telescope
          # Enables better syntax-aware searching and previewing
          treesitter = {
            enable = true;  # Enable TreeSitter integration with Telescope
          };
        };
      };
    };
  };
}
