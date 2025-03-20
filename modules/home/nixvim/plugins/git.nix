{
  programs.nixvim.plugins = {
    # Git Blame - Inline git blame information
    # Shows commit information for the current line directly in the editor
    gitblame = {
      enable = true;
      settings = {
        highlight_group = "String"; # This will use the String highlight color (often green)
        # Or try other built-in groups like:
        # "Identifier" (often blue)
        # "Special" (often orange/yellow)
        # "Type" (often yellow)
        # "Statement" (often purple)
      };
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
