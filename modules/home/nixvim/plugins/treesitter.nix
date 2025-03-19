{
  programs.nixvim.plugins = {
    # Treesitter - Advanced syntax highlighting and code parsing
    # Provides more accurate and performant syntax highlighting than regex-based highlighting
    treesitter = {
      enable = true;

      # Enable special injections for Nixvim configuration files
      # This provides better syntax highlighting for Nix code in Nixvim config files
      nixvimInjections = true;

      # Enable code folding based on syntax tree
      # Allows folding functions, classes, and other code blocks based on their structure
      folding = true;
      
      settings = {
        # Enable syntax-aware indentation
        # Provides better auto-indentation based on code structure
        indent.enable = true;
        
        # Enable syntax highlighting
        # The core feature of Treesitter - provides accurate and colorful syntax highlighting
        highlight.enable = true;

        # Install specific parsers that are needed
        ensure_installed = [
          "bash"
          "c"
          "cpp"
          "go"
          "html"        # Add HTML parser for HMTS
          "javascript"
          "json"
          "lua"
          "markdown"    # Make sure markdown is included for HMTS
          "nix"
          "python"
          "rust"
          "tsx"         # Add TSX parser for HMTS
          "typescript"
          "vim"
          "yaml"
        ];
        
        # Automatically install parsers when opening files of unknown types
        # Convenient for automatically supporting new languages as you encounter them
        auto_install = true;
      };
    };

    # Treesitter Refactor - Code navigation and smart renaming
    # Extends Treesitter with refactoring capabilities
    treesitter-refactor = {
      enable = true;
      
      # Highlight definition of symbol under cursor
      # Makes it easier to see where variables/functions are defined
      highlightDefinitions = {
        enable = true;
        
        # Don't clear highlights when moving cursor
        # Keeps definitions highlighted even when you move around
        # Set to false if you have an `updatetime` of ~100.
        clearOnCursorMove = false;
      };
    };

    # HMTS - HTML, Markdown, and TSX support for Treesitter
    # Enhances Treesitter's capabilities for web development languages
    # Temporarily disable HMTS to see if it resolves the error
    hmts = {
      enable = false;  # Disable HMTS temporarily to test if it's causing the issue
    };
  };
}
