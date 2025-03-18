{
  programs.nixvim = {
    globals = {
      # Disable useless providers
      loaded_ruby_provider = 0; # Ruby
      loaded_perl_provider = 0; # Perl
      loaded_python_provider = 0; # Python 2
    };

    opts = {
      # Split window behavior
      splitbelow = true; # Open new windows below current one
      splitright = true; # Open new windows to the right
      splitkeep = "cursor"; # Keep cursor position when splitting

      # Search behavior
      ignorecase = true; # Ignore case in search patterns
      smartcase = true; # Override ignorecase when search pattern has uppercase
      grepprg = "rg --vimgrep -uu --smart-case"; # Use ripgrep with smartcase

      # Line numbers
      nu = true; # Show line numbers
      number = true; # Equivalent to nu
      relativenumber = true; # Show relative line numbers

      # Tab settings
      tabstop = 4; # Width of a tab character
      softtabstop = 4; # Number of spaces for a tab in editing operations
      shiftwidth = 4; # Number of spaces for each indent
      expandtab = false; # Don't convert tabs to spaces (important for makefiles)
      smarttab = true; # Smart handling of tab at front of line

      # Command preview
      inccommand = "split"; # Show preview of substitutions in a split

      # Undo settings
      undodir = "$HOME/.local/state/nvim/undo"; # Directory for undo files
      undofile = true; # Save undo history to file

      # Performance and UI
      updatetime = 2000; # Faster completion and better experience
      lazyredraw = false; # Don't redraw screen during macros
      termguicolors = true; # Use true colors in terminal
      scrolloff = 999; # Keep cursor centered
      
      # Line wrapping
      linebreak = true; # Wrap at word boundaries
      
      # Visual block mode
      virtualedit = "block"; # Allow cursor beyond end of line in block mode
      
      # Sign column for diagnostics
      signcolumn = "yes:1"; # Always show sign column with width 1
      
      # List characters
      list = false; # Don't show invisible characters by default
      listchars = {
        eol = "↲";
        tab = "-->";
        trail = "+";
        extends = ">";
        precedes = "<";
        space = "·";
        nbsp = "␣";
      };
    };
  };
}
