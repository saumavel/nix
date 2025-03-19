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
    };
  };
}
