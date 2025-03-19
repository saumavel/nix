{
  programs.nixvim.autoCmd = [
    # Vertically center document when entering insert mode
    # This ensures that your cursor is always in the middle of the screen when you start typing,
    # which provides better context and reduces the need to manually scroll
    {
      event = "InsertEnter";  # Triggered when entering insert mode
      command = "norm zz";    # Execute normal mode 'zz' command to center the view on cursor
    }

    # Open help in a vertical split
    # By default, Vim/Neovim opens help in a horizontal split, which can be less convenient
    # for reading documentation. This changes it to a vertical split on the right side.
    {
      event = "FileType";     # Triggered when a buffer's filetype is set
      pattern = "help";       # Only apply to help files
      command = "wincmd L";   # Move the current window to the far right and make it vertical
    }

    # Enable spellcheck for specific filetypes
    # Automatically enables spell checking for content-focused file types
    # where spelling errors are important to catch
    {
      event = "FileType";     # Triggered when a buffer's filetype is set
      pattern = [
        "markdown"            # Markdown files - commonly used for documentation and writing
        # You can add more filetypes here as needed, such as:
        # "tex"               # LaTeX files
        # "text"              # Plain text files
        # "gitcommit"         # Git commit messages
      ];
      command = "setlocal spell spelllang=en";  # Enable spell checking with English dictionary
      # 'setlocal' applies settings only to the current buffer, not globally
    }
  ];
}
