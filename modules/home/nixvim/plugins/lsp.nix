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
      #---------------------------------------------------------------------------
      # DEVELOPMENT TOOLS
      #---------------------------------------------------------------------------

      # Keybinding helper that shows available key combinations
      # Helps remember complex keybindings
      which-key = {
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

      # Telescope - Fuzzy finder and picker
      # Provides unified interface for navigating lists of various kinds
      telescope = {
        enable = true;
        extensions = {
          fzf-native = {
            enable = true;
          };
          file_browser = {
            enable = true;
          };
          ui-select = {
            enable = true;
          };
        };
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
          "<leader>fh" = "help_tags";
          "<leader>fs" = "lsp_document_symbols";
          "<leader>fr" = "lsp_references";
          "<leader>fd" = "lsp_definitions";
        };
      };

      # Symbol Outline - Code structure viewer
      symbols-outline = {
        enable = true;
        settings = {
          auto_close = true;
          show_symbol_details = true;
          preview_bg_highlight = "Normal";
          keymaps = {
            close = "q";
            goto_location = "<CR>";
            focus_location = "o";
            hover_symbol = "K";
            rename_symbol = "r";
            code_actions = "a";
          };
        };
      };

      # LSP Status Indicator
      fidget = {
        enable = true;
        settings = {
          text = {
            spinner = "dots";
          };
          window = {
            blend = 0;
          };
        };
      };

      # Auto-pairs for better editing
      nvim-autopairs = {
        enable = true;
        checkTs = true;  # Use treesitter for better pair matching
        
        # Integrate with nvim-cmp
        settings.cmp = {
          enable = true;
        };
      };

      # LSP Signature Help
      lsp-signature = {
        enable = true;
        settings = {
          bind = true;
          handler_opts = {
            border = "rounded";
          };
          hint_enable = true;
          hint_prefix = "🔍 ";
          floating_window = true;
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

      # Null-LS for better linting and formatting
      null-ls = {
        enable = true;
        sources = {
          code_actions = {
            gitsigns.enable = true;
            statix.enable = true;     # Nix linting actions
          };
          diagnostics = {
            statix.enable = true;     # Nix linting
            shellcheck.enable = true; # Shell script linting
            flake8.enable = true;     # Python linting (alternative to pylint)
            eslint.enable = true;     # JavaScript/TypeScript linting
          };
          formatting = {
            nixfmt.enable = true;     # Nix formatting
            black.enable = true;      # Python formatting
            gofmt.enable = true;      # Go formatting
            prettier.enable = true;   # Web formatting
            stylua.enable = true;     # Lua formatting
          };
        };
      };

      # Better formatting with conform.nvim
      conform-nvim = {
        enable = true;
        formatOnSave = {
          enable = true;
          lspFallback = true;
        };
        formattersByFt = {
          lua = ["stylua"];
          python = ["black"];
          go = ["gofmt"];
          nix = ["nixfmt"];
          javascript = ["prettier"];
          typescript = ["prettier"];
          html = ["prettier"];
          css = ["prettier"];
          json = ["prettier"];
          yaml = ["prettier"];
          markdown = ["prettier"];
        };
      };

      #---------------------------------------------------------------------------
      # TREESITTER CONFIGURATION
      #---------------------------------------------------------------------------
      
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

      # Treesitter Context - Shows code context at the top of the screen
      treesitter-context = {
        enable = true;
      };

      # Treesitter Text Objects - Provides text objects based on treesitter nodes
      treesitter-textobjects = {
        enable = true;
        settings = {
          select = {
            enable = true;
            lookahead = true;
            keymaps = {
              "af" = "@function.outer";
              "if" = "@function.inner";
              "ac" = "@class.outer";
              "ic" = "@class.inner";
            };
          };
          move = {
            enable = true;
            set_jumps = true;
            goto_next_start = {
              "]m" = "@function.outer";
              "]]" = "@class.outer";
            };
            goto_previous_start = {
              "[m" = "@function.outer";
              "[[" = "@class.outer";
            };
          };
        };
      };

      # HMTS - HTML, Markdown, and TSX support for Treesitter
      # Enhances Treesitter's capabilities for web development languages
      hmts = {
        enable = true;  # Enable HMTS for better web development support
      };

      #---------------------------------------------------------------------------
      # COMPLETION CONFIGURATION
      #---------------------------------------------------------------------------

      # LuaSnip - Snippet engine
      # Provides snippet functionality and integration with nvim-cmp
      luasnip = {
        enable = true;
        fromVscode = [{}];  # Load all snippets from friendly-snippets
      };
      
      # Snippet collection
      friendly-snippets = {
        enable = true;  # Adds a collection of useful snippets for various languages
      };
      
      # Various completion sources for nvim-cmp
      # Each one provides completions from different sources
      cmp-omni.enable = true;                      # Integrates with Vim's omni-completion
      cmp-dap.enable = true;                       # Provides completions in Debug Adapter Protocol windows
      cmp-nvim-lsp.enable = true;                  # LSP completions
      cmp-nvim-lsp-document-symbol.enable = true;  # Document symbols from LSP
      cmp-nvim-lsp-signature-help.enable = true;   # Function signature help from LSP
      cmp-dictionary.enable = true;                # Dictionary word completions
      cmp-buffer.enable = true;                    # Better buffer completions
      cmp-path.enable = true;                      # Better path completions
      cmp-cmdline.enable = true;                   # Command line completions
      cmp-nvim-lua.enable = true;                  # Neovim Lua API completions
      cmp-git.enable = true;                       # Git completions for commit messages

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
            {name = "nvim_lsp";}   # LSP-provided completions (highest priority)
            {name = "luasnip";}    # Snippet completions
            {name = "path";}       # Filesystem path completions
            {name = "nvim_lua";}   # Neovim Lua API
            {
              name = "buffer";     # Completions from buffer text
              # This option makes completions available from all open buffers, not just the current one
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            }
            {name = "neorg";}      # Neorg-specific completions
            {name = "git";}        # Git completions
          ];
        };
      };

      #---------------------------------------------------------------------------
      # LSP CONFIGURATION
      #---------------------------------------------------------------------------

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

        # LSP diagnostics configuration
        settings = {
          diagnostics = {
            underline = true;
            update_in_insert = false;
            virtual_text = true;
            severity_sort = true;
            float = {
              border = "rounded";
              source = "always";
              header = "";
              prefix = "";
            };
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

      # Mason for easy LSP server management
      mason = {
        enable = true;
        settings = {
          ui = {
            border = "rounded";
            icons = {
              package_installed = "✓";
              package_pending = "➜";
              package_uninstalled = "✗";
            };
          };
        };
      };

      mason-lspconfig = {
        enable = true;
        automatic_installation = true;
      };
    };

    #---------------------------------------------------------------------------
    # KEYBINDINGS
    #---------------------------------------------------------------------------
    
    keymaps = [
      #---------------------------------------------------------------------------
      # TELESCOPE KEYBINDINGS
      #---------------------------------------------------------------------------

      # File navigation
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "Find files";
        };
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "Find with grep";
        };
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "Find buffers";
        };
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = "<cmd>Telescope oldfiles<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "Find recent files";
        };
      }

      # Navigation helpers
      {
        mode = "n";
        key = "<leader>fh";
        action = "<cmd>Telescope help_tags<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "Find help tags";
        };
      }
      {
        mode = "n";
        key = "<leader>fm";
        action = "<cmd>Telescope marks<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "Find marks";
        };
      }
      {
        mode = "n";
        key = "<leader>fc";
        action = "<cmd>Telescope commands<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "Find commands";
        };
      }
      {
        mode = "n";
        key = "<leader>fk";
        action = "<cmd>Telescope keymaps<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "Find keymaps";
        };
      }

      # Git operations
      {
        mode = "n";
        key = "<leader>gs";
        action = "<cmd>Telescope git_status<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "Git status";
        };
      }
      {
        mode = "n";
        key = "<leader>gc";
        action = "<cmd>Telescope git_commits<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "Git commits";
        };
      }

      # Current buffer operations
      {
        mode = "n";
        key = "<leader>/";
        action = "<cmd>Telescope current_buffer_fuzzy_find<cr>";
        options = {
          silent = true;
          noremap = true;
          desc = "Fuzzy find in current buffer";
        };
      }

      # Additional Telescope functionality
      {
        mode = "n";
        key = "<leader>u";
        action = ":Telescope undo<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Undo tree";
        };
      }

      #---------------------------------------------------------------------------
      # DEBUGGING (DAP) KEYBINDINGS
      #---------------------------------------------------------------------------

      # Breakpoint management
      {
        mode = "n";
        key = "<leader>b";
        action = ":DapToggleBreakpoint<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Toggle breakpoint";
        };
      }
      {
        mode = "n";
        key = "<leader>B";
        action = ":DapClearBreakpoints<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Clear all breakpoints";
        };
      }

      # Debugging control
      {
        mode = "n";
        key = "<leader>dc";
        action = ":DapContinue<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Start/Continue debugging";
        };
      }
      {
        mode = "n";
        key = "<leader>dso";
        action = ":DapStepOver<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Step over";
        };
      }
      {
        mode = "n";
        key = "<leader>dsi";
        action = ":DapStepInto<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Step into";
        };
      }
      {
        mode = "n";
        key = "<leader>dsO";
        action = ":DapStepOut<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Step out";
        };
      }
      {
        mode = "n";
        key = "<leader>dr";
        action = "<cmd>lua require('dap').run_to_cursor()<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Run to cursor";
        };
      }

      # DAP UI and session management
      {
        mode = "n";
        key = "<leader>du";
        action = "<cmd>lua require('dapui').toggle()<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Toggle DAP UI";
        };
      }
      {
        mode = "n";
        key = "<leader>dR";
        action = "<cmd>lua require('dap').restart()<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Restart debugging session";
        };
      }
      {
        mode = "n";
        key = "<leader>dT";
        action = "<cmd>lua require('nvim-dap-virtual-text').refresh()<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Refresh DAP Virtual Text";
        };
      }
    ];
  };
}
