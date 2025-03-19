{
  programs.nixvim = {
    globals = {
      # Disable useless providers to improve startup time and reduce dependencies
      loaded_ruby_provider = 0;   # Disable Ruby provider - not needed for most workflows
      loaded_perl_provider = 0;   # Disable Perl provider - rarely used in modern Neovim
      loaded_python_provider = 0; # Disable Python 2 provider - Python 2 is EOL
    };

    opts = {
      #---------------------------------------------------------------------------
      # WINDOW AND SPLIT BEHAVIOR
      #---------------------------------------------------------------------------
      
      # Control how new windows are created when splitting
      splitbelow = true;     # New horizontal splits appear below current window
      splitright = true;     # New vertical splits appear to the right of current window
      splitkeep = "cursor";  # Keep cursor in the same position when splitting windows
                             # (alternatives: "screen" or "topline")

      #---------------------------------------------------------------------------
      # SEARCH BEHAVIOR
      #---------------------------------------------------------------------------
      
      # Configure how searching works in the editor
      ignorecase = true;                       # Ignore case in search patterns by default
      smartcase = true;                        # Override ignorecase when pattern has uppercase
      grepprg = "rg --vimgrep -uu --smart-case"; # Use ripgrep for :grep command
                                                # --vimgrep: Output in vim-compatible format
                                                # -uu: Search hidden and ignored files
                                                # --smart-case: Case-insensitive unless pattern has uppercase

      #---------------------------------------------------------------------------
      # LINE NUMBERS
      #---------------------------------------------------------------------------
      
      # Configure line number display
      nu = true;             # Show line numbers (short form of number)
      number = true;         # Show line numbers (explicit form)
      relativenumber = true; # Show relative line numbers for easier vertical navigation
                             # Current line shows absolute number, other lines show distance

      #---------------------------------------------------------------------------
      # TAB AND INDENTATION SETTINGS
      #---------------------------------------------------------------------------
      
      # Configure how tabs and indentation work
      tabstop = 4;      # Width of a tab character in spaces
      softtabstop = 4;  # Number of spaces inserted when pressing Tab key
      shiftwidth = 4;   # Number of spaces for each level of indentation
      expandtab = false; # Don't convert tabs to spaces (important for makefiles and some languages)
      smarttab = true;  # Smart tab behavior at start of line (uses shiftwidth)
                        # When enabled, Tab in front of line inserts blanks according to shiftwidth

      #---------------------------------------------------------------------------
      # COMMAND AND PREVIEW SETTINGS
      #---------------------------------------------------------------------------
      
      # Configure how commands and previews work
      inccommand = "split"; # Show live preview of substitutions in a split window
                            # Alternatives: "nosplit" (inline preview) or "" (no preview)

      #---------------------------------------------------------------------------
      # UNDO SETTINGS
      #---------------------------------------------------------------------------
      
      # Configure persistent undo functionality
      undodir = "$HOME/.local/state/nvim/undo"; # Directory to store undo history files
      undofile = true;                          # Enable persistent undo (survives editor restart)

      #---------------------------------------------------------------------------
      # PERFORMANCE AND UI SETTINGS
      #---------------------------------------------------------------------------
      
      # Settings that affect performance and visual appearance
      updatetime = 2000;     # Milliseconds of inactivity before writing swap file
                             # Also affects CursorHold events and some plugins
                             # Lower values give better experience but higher CPU usage
      
      lazyredraw = false;    # Don't defer screen updates during macros
                             # Setting to true can improve performance but may cause visual glitches
      
      termguicolors = true;  # Use 24-bit RGB colors in terminal
                             # Enables richer color schemes but requires terminal support
      
      scrolloff = 999;       # Minimum lines to keep above/below cursor
                             # Setting to 999 keeps cursor centered vertically
      
      #---------------------------------------------------------------------------
      # TEXT DISPLAY SETTINGS
      #---------------------------------------------------------------------------
      
      # Configure how text is displayed
      linebreak = true;      # Wrap long lines at word boundaries rather than mid-word
                             # Only affects visual display, not the actual text
      
      virtualedit = "block"; # Allow cursor positioning where there is no actual character
                             # "block" enables only in visual block mode
                             # Alternatives: "all", "onemore", "insert", or ""
      
      #---------------------------------------------------------------------------
      # GUTTER AND SIGN SETTINGS
      #---------------------------------------------------------------------------
      
      # Configure the sign column (gutter) used by LSP, Git plugins, etc.
      signcolumn = "yes:1";  # Always show sign column with width of 1 character
                             # Prevents layout shift when signs appear/disappear
      
      #---------------------------------------------------------------------------
      # INVISIBLE CHARACTER DISPLAY
      #---------------------------------------------------------------------------
      
      # Configure display of normally invisible characters
      list = false;          # Don't show invisible characters by default
                             # Can be toggled with :set list / :set nolist
      
      # Define how invisible characters are displayed when 'list' is enabled
      listchars = {
        eol = "↲";           # End of line character
        tab = "-->";         # Tab characters (first char, middle chars, last char)
        trail = "+";         # Trailing spaces
        extends = ">";       # Indicates text continues beyond right of screen
        precedes = "<";      # Indicates text continues beyond left of screen
        space = "·";         # Normal spaces
        nbsp = "␣";          # Non-breaking spaces
      };
    };
  };
}
