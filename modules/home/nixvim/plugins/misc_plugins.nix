{
  programs.nixvim.plugins = {
    #---------------------------------------------------------------------------
    # UI ENHANCEMENTS
    #---------------------------------------------------------------------------
    
    # Provides filetype icons for various plugins
    # Used by many other plugins like barbar, telescope, etc.
    web-devicons = {
      enable = true;
    };
    
    # Smooth scrolling for Neovim
    # Enhances the scrolling experience with C-u and C-d
    neoscroll = {
      enable = true;
      settings = {
        mappings = [
          "<C-u>"  # Scroll up
          "<C-d>"  # Scroll down
        ];
      };
    };
    
    # Tab/buffer management with a nice looking bar
    # Allows easy navigation between open buffers
    barbar = {
      enable = true;
      keymaps = {
        next.key = "<TAB>";       # Go to next buffer
        previous.key = "<S-TAB>"; # Go to previous buffer
        close.key = "<leader>x";  # Close current buffer
      };
    };
    
    # Shows a sidebar with code structure (functions, classes, etc.)
    # Useful for navigating large files
    tagbar = {
      enable = true;
      settings.width = 50;  # Width of the tagbar window
    };
    
    # Quick file navigation and marking
    # Allows marking and quickly jumping between frequently used files
    harpoon = {
      enable = true;
      keymapsSilent = true;
      keymaps = {
        addFile = "<leader>a";     # Add current file to harpoon
        toggleQuickMenu = "<C-e>"; # Show harpoon menu
        navFile = {
          "1" = "<C-j>";  # Navigate to first marked file
          "2" = "<C-k>";  # Navigate to second marked file
          "3" = "<C-l>";  # Navigate to third marked file
          "4" = "<C-m>";  # Navigate to fourth marked file
        };
      };
    };
    
    #---------------------------------------------------------------------------
    # DEVELOPMENT TOOLS
    #---------------------------------------------------------------------------
    
    # Keybinding helper that shows available key combinations
    # Helps remember complex keybindings
    which-key = {
      enable = true;
    };
    
    # Commenting plugin for easy code commenting
    # Supports multiple languages and comment styles
    comment = {
      enable = true;
    };
    
    # Automatic indentation detection and setting
    # Adjusts indentation based on file content
    indent-o-matic = {
      enable = true;
    };
    
    # Diagnostics, references, telescope results, quickfix and location lists
    # Provides a better interface for viewing various lists
    trouble = {
      enable = true;
    };
    
    # Linting configuration for various file types
    # Integrates linters for different languages
    lint = {
      enable = true;
      lintersByFt = {
        text = ["vale"];             # Text linting with Vale
        markdown = ["vale"];         # Markdown linting with Vale
        dockerfile = ["hadolint"];   # Dockerfile linting
        terraform = ["tflint"];      # Terraform linting
        python = ["pylint"];         # Python linting
      };
    };
    
    #---------------------------------------------------------------------------
    # DEBUGGING TOOLS
    #---------------------------------------------------------------------------
    
    # Debug Adapter Protocol client implementation for Neovim
    # Core debugging functionality that connects to debug adapters
    dap = {
      enable = true;
    };
    
    # Go language support for nvim-dap
    # Configures DAP specifically for debugging Go applications
    dap-go = {
      enable = true;
    };
    
    # UI for nvim-dap
    # Provides a visual interface for the debugging experience
    dap-ui = {
      enable = true;
    };
    
    # Shows variable values as virtual text during debugging
    # Enhances debugging by displaying values inline with code
    dap-virtual-text = {
      enable = true;
    };
    
    # Testing framework integration
    # Provides a unified interface for running tests
    neotest = {
      enable = true;
      # Go testing adapter for neotest
      # Allows running Go tests through the neotest interface
      adapters.go = {
        enable = true;
      };
    };
    
    #---------------------------------------------------------------------------
    # LANGUAGE SPECIFIC PLUGINS
    #---------------------------------------------------------------------------
    
    # Nix language support
    # Provides syntax highlighting and other features for Nix files
    nix = {
      enable = true;
    };
    
    # Markdown preview functionality
    # Opens a browser window with rendered markdown
    markdown-preview = {
      enable = true;
      settings = {
        auto_close = 1;    # Auto close preview when changing buffer
        theme = "dark";    # Use dark theme for preview
      };
    };
  };
}
