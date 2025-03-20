{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.nixvim = {
    plugins.noice = {
      enable = true;
      settings = {
        fps = 60; # Testing if this causes too much CPU usage
        render = "wrapped-compact";
        max_width = 45;
        stages = "fade";
        timeout = 3000; # 3 seconds
        top_down = true; # false would show at the bottom

        notify = {
          enabled = true;
        };

        lsp = {
          # Override markdown rendering so that cmp and other plugins use Treesitter
          override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = false;
            "vim.lsp.util.stylize_markdown" = false;
            "cmp.entry.get_documentation" = false; # requires hrsh7th/nvim-cmp
          };
          hover = {
            enabled = false;
          };
          signature = {
            enabled = false;
          };
        };

        # Presets for easier configuration
        presets = {
          bottom_search = true; # Use a classic bottom cmdline for search
          command_palette = true; # Position the cmdline and popupmenu together
          long_message_to_split = true; # Long messages will be sent to a split
          inc_rename = false; # Enables an input dialog for inc-rename.nvim
          lsp_doc_border = false; # Add a border to hover docs and signature help
        };
      };
    };

    # Add the dependencies as extraPlugins
    extraPlugins = with pkgs.vimPlugins; [
      nui-nvim
      nvim-notify
    ];
  };
}
