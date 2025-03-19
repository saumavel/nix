{
  programs.nixvim = {
    # Global completion options
    # These control how the completion menu behaves
    opts.completeopt = [
      "menu"      # Use a popup menu to show the possible completions
      "menuone"   # Use the popup menu also when there is only one match
      "noselect"  # Do not select a match in the menu automatically, user must select explicitly
    ];

    plugins = {

      # Commenting plugin for easy code commenting
      # Supports multiple languages and comment styles
      comment = {
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

      # LuaSnip - Snippet engine
      # Provides snippet functionality and integration with nvim-cmp
      luasnip.enable = true;
      
      # Various completion sources for nvim-cmp
      # Each one provides completions from different sources
      cmp-omni.enable = true;                      # Integrates with Vim's omni-completion
      cmp-dap.enable = true;                       # Provides completions in Debug Adapter Protocol windows
      cmp-nvim-lsp.enable = true;                  # LSP completions
      cmp-nvim-lsp-document-symbol.enable = true;  # Document symbols from LSP
      cmp-nvim-lsp-signature-help.enable = true;   # Function signature help from LSP
      cmp-dictionary.enable = true;                # Dictionary word completions

      # LSP Kind - Visual enhancements for completion items
      # Adds icons and better formatting to completion menu items
      lspkind = {
        enable = true;

        # Integration with nvim-cmp
        cmp = {
          enable = true;
          # Custom labels for different completion sources in the completion menu
          menu = {
            nvim_lsp = "[LSP]";      # Language Server Protocol suggestions
            nvim_lua = "[api]";      # Neovim Lua API
            path = "[path]";         # Filesystem paths
            luasnip = "[snip]";      # Snippets
            buffer = "[buffer]";     # Text from current buffer
            neorg = "[neorg]";       # Neorg-specific completions
          };
        };
      };

      # nvim-cmp - The main completion engine
      # Provides the core completion functionality
      cmp = {
        enable = true;
        autoEnableSources = true;  # Automatically enable all configured sources

        settings = {
          # Snippet expansion function
          # This tells cmp how to expand snippets using LuaSnip
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";

          # Keybindings for controlling the completion menu
          mapping = {
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";        # Scroll documentation window up
            "<C-f>" = "cmp.mapping.scroll_docs(4)";         # Scroll documentation window down
            "<C-Space>" = "cmp.mapping.complete()";         # Trigger completion menu
            "<C-e>" = "cmp.mapping.close()";                # Close completion menu
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";     # Next suggestion
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";   # Previous suggestion
            "<CR>" = "cmp.mapping.confirm({ select = true })";  # Confirm selection
          };

          # Completion sources in priority order
          # Earlier sources in the list have higher priority
          sources = [
            {name = "path";}       # Filesystem path completions
            {name = "nvim_lsp";}   # LSP-provided completions (highest priority)
            {name = "luasnip";}    # Snippet completions
            {
              name = "buffer";     # Completions from buffer text
              # This option makes completions available from all open buffers, not just the current one
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            }
            {name = "neorg";}      # Neorg-specific completions
          ];
        };
      };

      # LSP configuration
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

