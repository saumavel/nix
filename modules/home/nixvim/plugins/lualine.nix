{
  programs.nixvim.plugins.lualine = {
    # Enable lualine - a blazing fast and easy to configure statusline
    # Provides a beautiful and informative status bar at the bottom of the editor
    enable = true;

    settings = {
      # Extensions automatically configure lualine for specific plugins
      # fzf extension adds proper status line when using the fzf finder
      extensions = [ "fzf" ];
      
      # Use a single global statusline instead of one per window
      # Creates a cleaner UI with just one status bar at the bottom
      globalstatus = true;

      # +-------------------------------------------------+
      # | A | B | C                             X | Y | Z |
      # +-------------------------------------------------+
      # Sections layout visualization - lualine has 6 sections:
      # - lualine_a, lualine_b, lualine_c on the left
      # - lualine_x, lualine_y, lualine_z on the right
      
      sections = {
        # Left sections
        lualine_a = ["mode"];      # Editor mode (NORMAL, INSERT, VISUAL, etc.)
        lualine_b = ["branch"];    # Git branch name
        lualine_c = [
          "filename"               # Current file name
          "diff"                   # Git diff status (added/modified/removed lines)
        ];

        # Right sections
        lualine_x = [
          "diagnostics"            # LSP diagnostics (errors, warnings, etc.)

          # Custom component: Show active language server
          # Displays which LSP server is currently active for the file
          # Helps confirm that the right language support is working
          {
            __raw = ''
              function()
                  local msg = ""
                  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                  local clients = vim.lsp.get_active_clients()
                  if next(clients) == nil then
                      return msg
                  end
                  for _, client in ipairs(clients) do
                      local filetypes = client.config.filetypes
                      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                          return client.name
                      end
                  end
                  return msg
              end
            '';
            color = {
              fg = "#ffffff";      # White text for good visibility
            };
          }

          # Custom component: Macro recording indicator
          # Shows when a macro is being recorded and which register it's using
          # Makes macro recording status much more visible than the default
          {
            __raw = ''
              function()
                  local recording_register = vim.fn.reg_recording()
                  if recording_register == "" then
                      return ""
                  else
                      return "Recording @" .. recording_register
                  end
              end
            '';
            color = {
              fg = "#ff0000";      # Bright red to make it very noticeable
            };
          }
          
          "encoding"               # File encoding (utf-8, etc.)
          "fileformat"             # Line ending format (unix, dos, etc.)
          "filetype"               # File type (python, javascript, etc.)
        ];
        
        # Note: lualine_y and lualine_z are not explicitly defined
        # They will use lualine's defaults (typically location and progress)
      };
    };
  };
}
