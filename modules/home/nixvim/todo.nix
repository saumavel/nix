{
  programs.nixvim = {
    # Custom syntax highlighting for TODO markers
    # Makes TODO markers stand out prominently in code and text files
    highlight.Todo = {
      fg = "Blue";     # Text color for TODO markers - blue for high visibility
      bg = "Yellow";   # Background color - yellow creates strong contrast with blue text
      # This high-contrast combination makes TODOs impossible to miss
    };

    # Pattern matching for TODO markers
    # Automatically highlights the word "TODO" in all files
    match.TODO = "TODO";  # Simple pattern to match exactly "TODO"
                          # Could be extended to more complex patterns like "TODO|FIXME|NOTE"

    # Keybinding to quickly find all TODOs in the project
    keymaps = [
      {
        mode = "n";       # Normal mode keybinding
        key = "<C-t>";    # Ctrl+T for "TODO" - easy to remember
        
        # Custom Lua function that uses Telescope to search for TODOs
        # This creates a powerful project-wide TODO finder
        action.__raw = ''
          function()
            require('telescope.builtin').live_grep({
              default_text="TODO",    -- Pre-populates the search with "TODO"
              initial_mode="normal"   -- Starts in normal mode instead of insert mode
                                      -- This allows immediate navigation through results
            })
          end
        '';
        
        options.silent = true;  # Execute without showing command in the command line
                                # Provides a cleaner user experience
      }
    ];
  };
}
