{
  programs.nixvim.plugins = {
    # Git Blame - Inline git blame information
    # Shows commit information for the current line directly in the editor
    gitblame = {
      enable = true;
      # Default configuration displays author and commit date in virtual text
      # Helps track when and by whom code was last modified without leaving the editor
      # Useful for understanding code history and responsibility
    };

    # LazyGit - Terminal UI for git commands
    # Provides a full-featured git interface within Neovim
    lazygit = {
      enable = true;
      # Integrates the LazyGit terminal UI directly into Neovim
      # Allows performing complex git operations (commit, branch, merge, etc.)
      # without leaving the editor
      # Can be opened with :LazyGit command by default
    };
  };
}
