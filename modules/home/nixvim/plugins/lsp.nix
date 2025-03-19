{
  programs.nixvim = {
    plugins = {
      lsp = {
        # Enable the LSP (Language Server Protocol) integration
        # This is the core of IDE-like features in Neovim
        enable = true;

        # Keybindings for LSP functionality
        # These provide quick access to common language features
        keymaps = {
          silent = true;  # Execute all keybindings silently (no command line echo)
          
          # Diagnostic navigation keymaps
          # These allow jumping between errors/warnings in your code
          diagnostic = {
            "<leader>k" = "goto_prev";  # Jump to previous diagnostic
            "<leader>j" = "goto_next";  # Jump to next diagnostic
          };

          # LSP buffer-specific keymaps
          # These provide core IDE features for the current file
          lspBuf = {
            gd = "definition";      # Go to definition of symbol under cursor
            gD = "references";      # Find all references to symbol under cursor
            gt = "type_definition"; # Go to type definition
            gi = "implementation";  # Go to implementation of interface
            K = "hover";            # Show documentation for symbol under cursor
            "<F2>" = "rename";      # Rename symbol across the entire project
          };
        };

        # Language server configurations
        # Each server provides language-specific features
        servers = {
          # Go language support
          gopls.enable = true;              # Official Go language server
          golangci_lint_ls.enable = true;   # Go linter integration
          
          # Lua language support
          lua_ls.enable = true;             # Lua language server
          
          # Nix language support
          nil_ls.enable = true;             # Nix language server
          
          # Python language support
          pyright.enable = true;            # Type checking for Python
          pylsp.enable = true;              # Python language server
          
          # Infrastructure and templating languages
          tflint.enable = true;             # Terraform linter
          templ.enable = true;              # Template language server
          
          # Web development
          html.enable = true;               # HTML language server
          htmx.enable = true;               # HTMX extension support
          tailwindcss.enable = true;        # Tailwind CSS intellisense
          
          # Protocol Buffers
          protols.enable = true;            # Protocol Buffers language server
        };
      };
    };
  };
}
