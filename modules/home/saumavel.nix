{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    # ./nixvim.nix

    inputs.catppuccin.homeManagerModules.catppuccin
  ];
  # THEME
  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  home = {
    # Define the state version
    enableNixpkgsReleaseCheck = false;
    stateVersion = "23.05";
    username = "saumavel";
    homeDirectory = "/Users/saumavel";

    sessionPath = [
      "$HOME/.nix-profile/bin"
      "/nix/var/nix/profiles/default/bin"
      "/run/current-system/sw/bin"
      "$HOME/.local/bin"
      "/opt/homebrew/bin"
      "/opt/homebrew/sbin"
      "/Users/saumavel/.local/share/nvim/lazy/mason.nvim/lua/mason-core/managers/composer"
      "/Users/saumavel/bin"
      "/Users/saumavel/.m2/wrapper/dists/apache-maven-3.9.7-bin/3k9n615lchs6mp84v355m633uo/apache-maven-3.9.7/bin"
    ];

    file = {
      ".hushlogin".text = "";
    };
  };

  # XDG Base Directory specification configuration
  # Manages application configurations and default applications
  xdg = {
    enable = true;
    configHome = "${config.home.homeDirectory}/.config";
    # Application-specific configuration files
    configFile = {
      # Ghostty configuration
      "ghostty/config".source = ./config/ghostty;
      # Keyboard customization
      "karabiner/karabiner.json".source = ./config/karabiner.json;
    };
    # Default applications for file types;
    mimeApps.defaultApplications = {
      # Web application
      "text/html" = "arc.desktop";
      # plain text files
      "text/plain" = "nvim.desktop";
      # PDF
      "application/pdf" = "mupdf.desktop";
    };
  };

  # NOTE: START HERE: Install packages that are only available in your user environment.
  # https://home-manager-options.extranix.com/
  programs = {
    # Enable Home Manager itself
    home-manager = {
      enable = true;
    };

    #
    # Shell and Terminal
    #

    bash.enable = true;

    fish = {
      enable = true;
      shellAliases = {
        n = "nvim";
        da = "direnv allow";
        dr = "direnv reload";
        ga = "git add";
        gc = "git commit";
        gco = "git checkout";
        gcp = "git cherry-pick";
        gdiff = "git diff";
        gl = "git pull";
        gp = "git push";
        gs = "git status";
        gt = "git tag";
        c = "clear";
        lg = "lazygit";
        cat = "bat";
      };
      interactiveShellInit =
        # bash
        ''
          # Do not show any greeting
          set fish_greeting

          set -g SHELL ${pkgs.fish}/bin/fish

          if test -e $HOME/.nix-profile/etc/profile.d/hm-session-vars.fish # source home-manager variables for nix
          source $HOME/.nix-profile/etc/profile.d/hm-session-vars.fish
          end

          # Ensure Nix-installed GCC and binaries come first
          set -gx PATH /Users/saumavel/.nix-profile/bin /nix/var/nix/profiles/default/bin /run/current-system/sw/bin $PATH

          # Prevent macOS CLT from overriding Nix paths
          set -gx PATH (string match -v /Library/Developer/CommandLineTools/usr/bin $PATH)

          # Add ~/.local/bin early
          set -gx PATH "$HOME/.local/bin" $PATH

          # SSH AGENT & AUTO SSH KEY ADD
          if test -z "$SSH_AUTH_SOCK"
          set -gx SSH_AUTH_SOCK (ssh-agent -c | awk '/SSH_AUTH_SOCK/ {print $3}' | sed 's/;//')
          end

          ssh-add -l > /dev/null; or ssh-add ~/.ssh/id_ed25519


          # HOME MANAGER & DARWIN SYSTEM PATHS
          fish_add_path --prepend /run/current-system/sw/bin

          # HOMEBREW CONFIGURATION
          if test -d /opt/homebrew
          set -gx HOMEBREW_PREFIX /opt/homebrew
          set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
          set -gx HOMEBREW_REPOSITORY /opt/homebrew
          set -gx PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH
          set -gx MANPATH /opt/homebrew/share/man $MANPATH
          set -gx INFOPATH /opt/homebrew/share/info $INFOPATH
          end

          # ADDITIONAL TOOLS (Composer, Java, etc.)
          set -gx PATH /Users/saumavel/.local/share/nvim/lazy/mason.nvim/lua/mason-core/managers/composer /Users/saumavel/bin $PATH
          set -gx PATH /Users/saumavel/.m2/wrapper/dists/apache-maven-3.9.7-bin/3k9n615lchs6mp84v355m633uo/apache-maven-3.9.7/bin $PATH

          # ALIASES FOR NIX
          alias gcc '/Users/saumavel/.nix-profile/bin/gcc'
          alias g++ '/Users/saumavel/.nix-profile/bin/g++'
          alias cpp '/Users/saumavel/.nix-profile/bin/cpp'
        '';
    };

    # Neovim
    nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      luaLoader.enable = true;

      colorschemes = {
        catppuccin = {
          enable = true;
        };
      };
      # ==========================================================================
      # AUTOCOMMANDS (autoCmd)
      # ==========================================================================
      autoCmd = [
        {
          event = "InsertEnter";
          command = "normal! zz";
          desc = "Vertically center on InsertEnter";
        }
        {
          event = "FileType";
          pattern = ["help"];
          command = "wincmd L";
          desc = "Open help in a vertical split";
        }
        {
          event = ["FileType"];
          pattern = ["markdown"];
          command = "setlocal spell spelllang=en";
          desc = "Enable spellcheck for Markdown";
        }
      ];

      # ==========================================================================
      # GLOBAL PROVIDER DISABLES
      # ==========================================================================
      globals = {
        mapleader = " ";
        maplocalleader = " ";
        loaded_ruby_provider = 0;
        loaded_perl_provider = 0;
        loaded_python_provider = 0; # Disables Python 2 provider
      };

      # ==========================================================================
      # EDITOR OPTIONS
      # ==========================================================================
      opts = {
        completeopt = ["menu" "menuone" "noselect"];
        splitbelow = true;
        splitright = true;
        splitkeep = "cursor";
        ignorecase = true;
        smartcase = true;
        grepprg = "rg --vimgrep -uu --smart-case";
        nu = true;
        number = true;
        relativenumber = true;
        tabstop = 4;
        softtabstop = 4;
        shiftwidth = 4;
        expandtab = false;
        smarttab = true;
        inccommand = "split";
        undodir = "$HOME/.local/state/nvim/undo";
        undofile = true;
        updatetime = 2000;
        lazyredraw = false;
        termguicolors = true;
        scrolloff = 999;
        linebreak = true;
        virtualedit = "block";
        signcolumn = "yes:1";
        list = false;
        listchars = {
          eol = "↲";
          tab = "-->";
          trail = "+";
          extends = ">";
          precedes = "<";
          space = "·";
          nbsp = "␣";
        };
      };

      # ==========================================================================
      # COMPLETION MENU SETTINGS
      # ==========================================================================
      plugins = {
        # ---------------------------------------------------------------------------
        # TODO HIGHLIGHTING & KEYMAP
        # ---------------------------------------------------------------------------
        todo-comments = {
          enable = true;
          # A minimal example of customizing highlight
          settings = {
            highlight = {
              pattern = [
                ".*<(KEYWORDS)\\s*:" # or use your own regex
              ];
            };
            keywords = {
              TODO = {
                color = "info"; # uses the default “info” color
                alt = ["FIXME" "BUG"]; # optionally treat FIXME/BUG as input
              };
            };
          };
        };
        #=========================================================================
        # FILE NAVIGATION & MANAGEMENT
        #=========================================================================

        # Oil.nvim - File explorer that lets you edit the filesystem like a buffer
        # https://github.com/stevearc/oil.nvim
        oil = {
          enable = true;
          settings = {
            # Replace netrw with Oil for a more powerful file explorer
            default_file_explorer = true;

            # Show file icons for better visual identification
            columns = ["icon"];

            # Usability improvements
            skip_confirm_for_simple_edits = true;
            prompt_save_on_select_new_entry = true;
            constrain_cursor = "editable";
            watch_for_changes = true;

            # File visibility settings
            view_options = {
              show_hidden = true; # Show dotfiles (toggle with g.)
            };

            # Custom keymaps for Oil navigation and actions
            keymaps = {
              # Navigation
              "g?" = "actions.show_help";
              "l" = "actions.select";
              "<Cr>" = "actions.select";
              "h" = "actions.parent";
              "-" = "actions.open_cwd";
              "~" = "actions.cd";

              # Split operations
              "<C-s>" = {
                __raw = ''{ "actions.select", opts = { vertical = true }, desc = "Open in vertical split" }'';
              };
              "<C-v>" = {
                __raw = ''{ "actions.select", opts = { horizontal = true }, desc = "Open in horizontal split" }'';
              };

              # View controls
              "<C-p>" = "actions.preview";
              "<C-c>" = "actions.close";
              "<C-l>" = "actions.refresh";
              "gs" = "actions.change_sort";
              "gx" = "actions.open_external";
              "g." = "actions.toggle_hidden";
              "g\\" = "actions.toggle_trash";

              # FZF integration
              "<leader>ff" = {
                __raw = ''
                  function()
                    require("fzf-lua").files({
                      cwd = require("oil").get_current_dir()
                    })
                  end
                '';
                mode = "n";
                nowait = true;
                desc = "Find files in current directory";
              };
              "<leader>fj" = {
                __raw = ''
                  function()
                    require("fzf-lua").live_grep({
                      cwd = require("oil").get_current_dir()
                    })
                  end
                '';
                mode = "n";
                nowait = true;
                desc = "Grep in current directory";
              };

              # PDF handling
              "zp" = {
                __raw = ''
                  function()
                    local oil = require("oil")
                    local name = oil.get_cursor_entry().name
                    if name:match("%.pdf$") then
                      local path = oil.get_current_dir() .. name
                      vim.fn.jobstart(string.format("mupdf %s", vim.fn.shellescape(path)))
                    end
                  end
                '';
                desc = "Open PDF in MuPDF";
              };
            };

            # Disable default keymaps to avoid conflicts
            use_default_keymaps = false;
          };
        };

        # Harpoon - Quick file navigation and marking
        # https://github.com/ThePrimeagen/harpoon
        harpoon = {
          enable = true;
          keymapsSilent = true;
          keymaps = {
            addFile = "<leader>a"; # Mark current file
            toggleQuickMenu = "<C-e>"; # Show harpoon menu
            navFile = {
              "1" = "<C-1>"; # Jump to mark 1
              "2" = "<C-2>"; # Jump to mark 2
              "3" = "<C-3>"; # Jump to mark 3
              "4" = "<C-4>"; # Jump to mark 4
              "5" = "<C-5>"; # Jump to mark 1
              "6" = "<C-6>"; # Jump to mark 2
              "7" = "<C-7>"; # Jump to mark 3
              "8" = "<C-8>"; # Jump to mark 4
              "9" = "<C-9>"; # Jump to mark 3
            };
          };
        };

        # Telescope - Advanced fuzzy finder
        # https://github.com/nvim-telescope/telescope.nvim
        telescope = {
          enable = true;

          # Configure main Telescope settings
          settings = {
            defaults = {
              # Your existing defaults...
              file_ignore_patterns = [
                "^.git/"
                "^.mypy_cache/"
                "^__pycache__/"
                "^output/"
                "^data/"
                "%.ipynb"
              ];
              set_env = {
                COLORTERM = "truecolor";
              };
              mappings = {
                i = {
                  "<C-j>" = "move_selection_next";
                  "<C-k>" = "move_selection_previous";
                  "<C-n>" = "move_selection_next";
                  "<C-p>" = "move_selection_previous";
                  "<C-Down>" = "cycle_history_next";
                  "<C-Up>" = "cycle_history_prev";
                  "<C-c>" = "close";
                  "<C-u>" = "preview_scrolling_up";
                  "<C-d>" = "preview_scrolling_down";
                };
                n = {
                  "<C-j>" = "move_selection_next";
                  "<C-k>" = "move_selection_previous";
                  "q" = "close";
                  "<C-c>" = "close";
                  "<C-u>" = "preview_scrolling_up";
                  "<C-d>" = "preview_scrolling_down";
                };
              };

              # Additional recommended settings
              path_display = ["truncate"];
              selection_caret = "❯ ";
              prompt_prefix = "🔍 ";
              sorting_strategy = "ascending";
            };
          };

          # Configure extensions properly using the extensions namespace
          extensions = {
            # FZF Native extension
            "fzf-native" = {
              enable = true;
              settings = {
                fuzzy = true;
                override_generic_sorter = true;
                override_file_sorter = true;
                case_mode = "smart_case";
              };
            };

            # File Browser extension
            "file-browser" = {
              enable = true;
              settings = {
                hijack_netrw = true;
                hidden = true;
                respect_gitignore = true;
              };
            };

            # UI Select extension
            "ui-select" = {
              enable = true;
              settings = {
                # Any ui-select specific settings
              };
            };
          };
        };

        #=========================================================================
        # UI ENHANCEMENTS
        #=========================================================================

        # File icons for various plugins
        # https://github.com/nvim-tree/nvim-web-devicons
        web-devicons.enable = true;

        # Smooth scrolling for better navigation experience
        # https://github.com/karb94/neoscroll.nvim
        neoscroll = {
          enable = true;
          settings.mappings = [
            "<C-u>" # Smooth scroll up
            "<C-d>" # Smooth scroll down
          ];
        };

        # Tab/buffer management with visual indicators
        # https://github.com/romgrk/barbar.nvim
        barbar = {
          enable = true;
          keymaps = {
            next.key = "<TAB>"; # Go to next buffer
            previous.key = "<S-TAB>"; # Go to previous buffer
            close.key = "<leader>x"; # Close current buffer
          };
        };

        # Code structure sidebar
        # https://github.com/preservim/tagbar
        tagbar = {
          enable = true;
          settings.width = 50; # Width of tagbar window
        };

        # Seamless navigation between tmux and vim
        # https://github.com/christoomey/vim-tmux-navigator
        tmux-navigator.enable = true;

        # Notification and command line UI enhancement
        # https://github.com/folke/noice.nvim
        noice = {
          enable = true;
          settings = {
            fps = 60;
            render = "wrapped-compact";
            max_width = 45;
            stages = "fade";
            timeout = 3000;
            top_down = true;

            notify.enabled = true;

            # LSP display settings
            lsp = {
              override = {
                "vim.lsp.util.convert_input_to_markdown_lines" = false;
                "vim.lsp.util.stylize_markdown" = false;
                "cmp.entry.get_documentation" = false;
              };
              hover.enabled = false;
              signature.enabled = false;
            };

            # UI presets
            presets = {
              bottom_search = true;
              command_palette = true;
              long_message_to_split = true;
              inc_rename = false;
              lsp_doc_border = false;
            };
          };
        };

        # # Required dependencies for noice
        # extraPlugins = with pkgs.vimPlugins; [
        #   nui-nvim
        #   nvim-notify
        # ];

        # Status line with rich information
        # https://github.com/nvim-lualine/lualine.nvim
        lualine = {
          enable = true;
          settings = {
            extensions = ["fzf"];
            globalstatus = true; # Single global statusline

            sections = {
              # Left sections
              lualine_a = ["mode"];
              lualine_b = ["branch"];
              lualine_c = [
                "filename"
                "diff"
              ];

              # Right sections
              lualine_x = [
                "diagnostics"

                # Active LSP server indicator
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
                    fg = "#ffffff";
                  };
                }

                # Macro recording indicator
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
                    fg = "#ff0000";
                  };
                }

                "encoding"
                "fileformat"
                "filetype"
              ];
            };
          };
        };

        #=========================================================================
        # GIT INTEGRATION
        #=========================================================================

        # Inline git blame information
        # https://github.com/f-person/git-blame.nvim
        gitblame = {
          enable = true;
          settings.highlight_group = "String"; # Use String highlight color
        };

        # Full-featured git interface
        # https://github.com/kdheepak/lazygit.nvim
        lazygit.enable = true;

        #=========================================================================
        # EDITOR ENHANCEMENTS
        #=========================================================================

        # Interactive key binding help
        # https://github.com/folke/which-key.nvim
        which-key.enable = true;

        # Automatic indentation detection
        # https://github.com/Darazaki/indent-o-matic
        indent-o-matic.enable = true;

        # Better diagnostics, references, and quickfix lists
        # https://github.com/folke/trouble.nvim
        trouble.enable = true;

        # AI code completion
        # https://github.com/github/copilot.vim
        copilot-vim = {
          enable = true;
          settings.filetypes = {
            "*" = true; # Enable for all filetypes
          };
        };

        # Automatic bracket pairing
        # https://github.com/windwp/nvim-autopairs
        nvim-autopairs = {
          enable = true;
          settings = {
            check_ts = true; # Use treesitter for better matching
            cmp.enable = true; # Integration with nvim-cmp
          };
        };

        # Code commenting utilities
        # https://github.com/numToStr/Comment.nvim
        comment.enable = true;

        #=========================================================================
        # SNACKS - NEOVIM ENHANCEMENT SUITE
        #=========================================================================

        # Snacks - Collection of Neovim enhancements
        # https://github.com/echasnovski/mini.nvim
        snacks = {
          enable = true;
          autoLoad = true;

          # Lua configuration that runs before loading
          luaConfig.pre = ''
            vim.api.nvim_create_autocmd("User", {
              pattern = "VeryLazy",
              callback = function()
                -- Setup debugging globals
                _G.dd = function(...)
                  Snacks.debug.inspect(...)
                end
                _G.bt = function()
                  Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print for `:=` command

                -- Toggle mappings
                Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>.z")
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>.w")
                Snacks.toggle.diagnostics():map("<leader>.D")
                Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                  :map("<leader>.c")
                Snacks.toggle.treesitter():map("<leader>.T")
                Snacks.toggle.inlay_hints():map("<leader>.h")
                Snacks.toggle.scroll():map("<leader>.S")
                Snacks.toggle.zen():map("<leader>.f")
                Snacks.toggle.dim():map("<leader>.d")
              end,
            })
          '';

          # Snacks module settings
          settings = {
            # Picker module (fuzzy finder)
            picker = {
              enabled = true;
              icons = true;
              theme = "dropdown";
              previewer.enabled = true;
              finder = {
                hidden = false;
                no_ignore = false;
              };
              use_telescope = true; # Use Telescope configuration
            };

            terminal = {
              enabled = true;
              direction = "vertical"; # float, horizontal, vertical
              size = {
                width = 0.8;
                height = 0.8;
              };
            };

            # Large file handling
            bigfile.enabled = true;

            # Notification system
            notifier = {
              enabled = true;
              timeout = 3000;
              style = "compact";
              top_down = false;
              margin = {
                top = 0;
                right = 0;
                bottom = 0;
              };
            };

            # Code indentation visualization
            indent = {
              indent = {
                enabled = false;
                only_scope = false;
                only_current = false;
              };
              animate = {
                style = "out";
                duration = {
                  step = 20;
                  total = 100;
                };
              };
              scope = {
                enabled = true;
                underline = false;
                only_current = true;
              };
              chunk = {
                enabled = false;
                char = {
                  corner_top = "╭";
                  corner_bottom = "╰";
                  horizontal = "─";
                  vertical = "│";
                  arrow = ">";
                };
              };
            };

            # UI styling
            styles = {
              notification = {
                wo = {wrap = true;};
              };
              input = {
                backdrop = false;
                width = 30;
                relative = "cursor";
                row = -3;
                col = 0;
                b = {
                  completion = true;
                };
              };
            };

            #=========================================================================
            # DASHBOARD
            #=========================================================================
            # Dashboard with block-style NEOVIM ASCII art
            dashboard = {
              enabled = true;
              sections = [
                # ASCII art header
                {
                  section = "header";
                  content = [
                    "    ████  ███ ████ ████ ████ █   █████  "
                    "     ██ █  ██  ██   ██  ██   ██  ██     "
                    "     ██    ██  ██   ██  ███  ██  ████   "
                    "     ██ █  ██  ██   ██  ██   ██  ██     "
                    "    ████  ███ ████  ██  ██   ███ █████  "
                    "                                        "
                    "                NEOVIM                  "
                  ];
                }
                {
                  type = "padding";
                  val = 1;
                }
                {
                  section = "keys";
                  title = "Shortcuts";
                  items = [
                    {
                      key = "SPC f f";
                      desc = "Find Files";
                    }
                    {
                      key = "SPC f g";
                      desc = "Live Grep";
                    }
                    {
                      key = "SPC f b";
                      desc = "Find Buffers";
                    }
                    {
                      key = "SPC g g";
                      desc = "Open Lazygit";
                    }
                    {
                      key = "SPC t";
                      desc = "Terminal";
                    }
                    {
                      key = "SPC .";
                      desc = "Toggle Options";
                    }
                  ];
                  gap = 1;
                  padding = 1;
                }
                {
                  pane = 2;
                  icon = " ";
                  title = "Recent Files";
                  section = "recent_files";
                  indent = 2;
                  padding = 1;
                }
                {
                  pane = 2;
                  icon = " ";
                  title = "Projects";
                  section = "projects";
                  indent = 2;
                  padding = 1;
                }
                {
                  pane = 2;
                  icon = " ";
                  title = "Git Status";
                  section = "terminal";
                  enabled = "__raw vim.fn.isdirectory('.git') == 1";
                  cmd = "git status -bs --ignore-submodules";
                  height = 5;
                  padding = 1;
                  ttl = 300;
                  indent = 3;
                }
              ];

              # Dashboard style options
              style = {
                header = {
                  fg = "#89b4fa"; # Catppuccin blue
                  bold = true;
                };
                section_title = {
                  fg = "#f5c2e7"; # Catppuccin pink
                  bold = true;
                };
                keys_icon = {
                  fg = "#a6e3a1"; # Catppuccin green
                };
                keys_key = {
                  fg = "#f9e2af"; # Catppuccin yellow
                  bold = true;
                };
              };
            };
          };
        };

        #=========================================================================
        # LSP INTEGRATION
        #=========================================================================

        # LSP status indicator
        # https://github.com/j-hui/fidget.nvim
        fidget.enable = true;

        # LSP signature help popup
        # https://github.com/ray-x/lsp_signature.nvim
        lsp-signature = {
          enable = true;
          settings = {
            bind = true;
            handler_opts = {border = "rounded";};
            hint_enable = true;
            hint_prefix = "🔍 ";
            floating_window = true;
          };
        };

        # Language Server Protocol configuration
        lsp = {
          enable = true;

          # LSP keybindings
          keymaps = {
            silent = true;

            # Diagnostic navigation
            diagnostic = {
              "<leader>k" = "goto_prev";
              "<leader>j" = "goto_next";
            };

            # Code navigation and actions
            lspBuf = {
              gd = "definition";
              gD = "references";
              gt = "type_definition";
              gi = "implementation";
              I = "hover";
              "<F2>" = "rename";
            };
          };

          # Language server configurations
          servers = {
            # Go
            gopls.enable = true;
            golangci_lint_ls.enable = true;

            # Lua
            lua_ls.enable = true;

            # Nix
            nil_ls.enable = true;

            # Python
            pyright.enable = true;
            pylsp.enable = true;

            # Infrastructure
            tflint.enable = true;
            templ.enable = true;

            # Web development
            html.enable = true;
            htmx.enable = true;
            tailwindcss.enable = true;

            # Protocol Buffers
            protols.enable = true;
          };

          # Diagnostic configuration
          postConfig = ''
            vim.diagnostic.config({
              underline = true,
              update_in_insert = false,
              virtual_text = true,
              severity_sort = true,
              float = {
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
              },
            })
          '';
        };

        #=========================================================================
        # CODE FORMATTING & LINTING
        #=========================================================================

        # Linting configuration
        lint = {
          enable = true;
          lintersByFt = {
            text = ["vale"];
            markdown = ["vale"];
            dockerfile = ["hadolint"];
            terraform = ["tflint"];
            python = ["pylint"];
          };
        };

        # Code formatting
        conform-nvim = {
          enable = true;
          settings = {
            format_on_save = {
              enable = true;
              lsp_fallback = true;
            };

            # Language-specific formatters
            formatters_by_ft = {
              lua = ["stylua"];
              python = ["black"];
              go = ["gofmt"];
              nix = ["alejandra"];
              javascript = ["prettier"];
              typescript = ["prettier"];
              html = ["prettier"];
              css = ["prettier"];
              json = ["prettier"];
              yaml = ["prettier"];
              markdown = ["prettier"];
            };
          };
        };

        #=========================================================================
        # SYNTAX & LANGUAGE SUPPORT
        #=========================================================================

        # Nix language support
        nix.enable = true;

        # Markdown preview
        markdown-preview = {
          enable = true;
          settings = {
            auto_close = 1;
            theme = "dark";
          };
        };

        # Treesitter - Advanced syntax highlighting
        # https://github.com/nvim-treesitter/nvim-treesitter
        treesitter = {
          enable = true;
          nixvimInjections = true;
          folding = false;

          settings = {
            indent.enable = true;
            highlight.enable = true;

            # Languages to support
            ensure_installed = [
              "bash"
              "c"
              "cpp"
              "go"
              "html"
              "javascript"
              "json"
              "lua"
              "markdown"
              "nix"
              "python"
              "rust"
              "tsx"
              "typescript"
              "vim"
              "yaml"
            ];

            auto_install = true;
          };
        };

        # Treesitter extensions
        treesitter-refactor = {
          enable = true;
          highlightDefinitions = {
            enable = true;
            clearOnCursorMove = false;
          };
        };

        treesitter-context.enable = true;

        treesitter-textobjects = {
          enable = true;
          extraOptions = {
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

        #=========================================================================
        # COMPLETION & SNIPPETS
        #=========================================================================

        # Snippet engine
        luasnip = {
          enable = true;
          fromVscode = [{}]; # Load snippets from friendly-snippets
        };

        # Snippet collection
        friendly-snippets.enable = true;

        # Completion sources
        cmp-omni.enable = true;
        cmp-dap.enable = true;
        cmp-nvim-lsp.enable = true;
        cmp-nvim-lsp-document-symbol.enable = true;
        cmp-nvim-lsp-signature-help.enable = true;
        cmp-dictionary.enable = true;
        cmp-buffer.enable = true;
        cmp-path.enable = true;
        cmp-cmdline.enable = true;
        cmp-nvim-lua.enable = true;
        cmp-git.enable = true;

        # Completion menu styling
        lspkind = {
          enable = true;
          mode = "symbol_text";
          preset = "codicons";

          cmp = {
            enable = true;
            menu = {
              nvim_lsp = "[LSP]";
              nvim_lua = "[api]";
              path = "[path]";
              luasnip = "[snip]";
              buffer = "[buffer]";
              neorg = "[neorg]";
            };
          };
        };

        # Main completion engine
        cmp = {
          enable = true;
          autoEnableSources = true;

          settings = {
            snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";

            # Keybindings
            mapping = {
              "<C-d>" = "cmp.mapping.scroll_docs(-4)";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-e>" = "cmp.mapping.close()";
              "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
              "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              "<CR>" = "cmp.mapping.confirm({ select = true })";
            };

            # Completion sources in priority order
            sources = [
              {name = "nvim_lsp";}
              {name = "luasnip";}
              {name = "path";}
              {name = "nvim_lua";}
              {
                name = "buffer";
                option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
              }
              {name = "neorg";}
              {name = "git";}
            ];
          };
        };

        #=========================================================================
        # DEBUGGING TOOLS
        #=========================================================================

        # Debug Adapter Protocol
        dap.enable = true;

        # Language-specific debugging
        dap-go.enable = true;

        # Debugging UI
        dap-ui.enable = true;

        # Inline variable values
        dap-virtual-text.enable = true;

        # Testing framework
        neotest = {
          enable = true;
          adapters.go.enable = true;
        };
      };

      #===========================================================================
      # KEYMAPS
      #===========================================================================

      keymaps = [
        #-------------------------------------------------------------------------
        # SNACKS FINDER & PICKER KEYMAPS
        #-------------------------------------------------------------------------

        # Buffer and file searching
        {
          mode = "n";
          key = "<leader>/";
          action = "function() Snacks.picker.current_buffer_fuzzy_find() end";
          options = {
            silent = true;
            desc = "Fuzzy find in current buffer";
          };
        }
        {
          mode = "n";
          key = "<leader>fm";
          action = "function() Snacks.picker.marks() end";
          options = {
            silent = true;
            desc = "Find marks";
          };
        }
        {
          mode = "n";
          key = "<leader>fc";
          action = "function() Snacks.picker.commands() end";
          options = {
            silent = true;
            desc = "Find commands";
          };
        }
        {
          mode = "n";
          key = "<leader>fk";
          action = "function() Snacks.picker.keymaps() end";
          options = {
            silent = true;
            desc = "Find keymaps";
          };
        }
        {
          mode = "n";
          key = "<leader>gs";
          action = "function() Snacks.picker.git_status() end";
          options = {
            silent = true;
            desc = "Git status";
          };
        }
        {
          mode = "n";
          key = "<leader>gc";
          action = "function() Snacks.picker.git_commits() end";
          options = {
            silent = true;
            desc = "Git commits";
          };
        }
        {
          mode = "n";
          key = "<leader>u";
          action = "function() Snacks.picker.undo() end";
          options = {
            silent = true;
            desc = "Undo tree";
          };
        }

        #-------------------------------------------------------------------------
        # NOTIFICATION KEYMAPS
        #-------------------------------------------------------------------------

        {
          mode = "n";
          key = "<leader>n";
          action = "function() Snacks.notifier.hide() end";
          options = {
            silent = true;
            desc = "Dismiss All Notifications";
          };
        }
        {
          mode = "n";
          key = "<leader>N";
          action = "function() Snacks.notifier.show_history() end";
          options = {
            silent = true;
            desc = "Show notification history";
          };
        }

        #-------------------------------------------------------------------------
        # GIT KEYMAPS
        #-------------------------------------------------------------------------

        {
          mode = "n";
          key = "<leader>gg";
          action = "function() Snacks.lazygit() end";
          options = {
            silent = true;
            desc = "Lazygit";
          };
        }
        {
          mode = "n";
          key = "<leader>gB";
          action = "function() Snacks.gitbrowse() end";
          options = {
            silent = true;
            desc = "Git Browse";
          };
        }
        {
          mode = "n";
          key = "<leader>gf";
          action = "function() Snacks.lazygit.log_file() end";
          options = {
            silent = true;
            desc = "Lazygit Current File History";
          };
        }
        {
          mode = "n";
          key = "<leader>gl";
          action = "function() Snacks.lazygit.log() end";
          options = {
            silent = true;
            desc = "Lazygit Log (cwd)";
          };
        }

        #-------------------------------------------------------------------------
        # TERMINAL KEYMAPS
        #-------------------------------------------------------------------------

        {
          mode = "n";
          key = "<leader>t";
          action = "function() Snacks.terminal() end";
          options = {
            silent = true;
            desc = "Toggle Terminal";
          };
        }
        {
          mode = "n";
          key = "<c-_>";
          action = "function() Snacks.terminal() end";
          options = {
            silent = true;
            desc = "which_key_ignore";
          };
        }

        #-------------------------------------------------------------------------
        # FILE NAVIGATION KEYMAPS
        #-------------------------------------------------------------------------

        {
          mode = "n";
          key = "<leader>ff";
          action = "function() Snacks.find.files() end";
          options = {
            silent = true;
            desc = "Find Files";
          };
        }
        {
          mode = "n";
          key = "<leader>fg";
          action = "function() Snacks.find.grep() end";
          options = {
            silent = true;
            desc = "Live Grep";
          };
        }
        {
          mode = "n";
          key = "<leader>fb";
          action = "function() Snacks.find.buffers() end";
          options = {
            silent = true;
            desc = "Find Buffers";
          };
        }
        {
          mode = "n";
          key = "<leader>fh";
          action = "function() Snacks.find.help() end";
          options = {
            silent = true;
            desc = "Find Help";
          };
        }

        #-------------------------------------------------------------------------
        # LSP NAVIGATION KEYMAPS
        #-------------------------------------------------------------------------

        {
          mode = "n";
          key = "<leader>fs";
          action = "function() Snacks.find.lsp_document_symbols() end";
          options = {
            silent = true;
            desc = "Find Document Symbols";
          };
        }
        {
          mode = "n";
          key = "<leader>fr";
          action = "function() Snacks.find.lsp_references() end";
          options = {
            silent = true;
            desc = "Find References";
          };
        }
        {
          mode = "n";
          key = "<leader>fd";
          action = "function() Snacks.find.lsp_definitions() end";
          options = {
            silent = true;
            desc = "Find Definitions";
          };
        }

        #-------------------------------------------------------------------------
        # COPILOT KEYMAPS
        #-------------------------------------------------------------------------

        {
          mode = "i";
          key = "<C-a>";
          action = "copilot#Accept('<CR>')";
          options = {
            silent = true;
            expr = true;
            script = true;
            desc = "Accept Copilot suggestion";
          };
        }

        #-------------------------------------------------------------------------
        # DEBUGGING KEYMAPS
        #-------------------------------------------------------------------------

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

        # DAP UI
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
        #---------------------------------------------------------------------------
        # PLUGIN: Barbar - Buffer Navigation
        #---------------------------------------------------------------------------
        {
          mode = "n";
          key = "<Tab>";
          action = ":BufferNext<CR>";
          options = {
            silent = true;
            noremap = true;
            desc = "Next buffer (Barbar)";
          };
        }
        {
          mode = "n";
          key = "<S-Tab>";
          action = ":BufferPrevious<CR>";
          options = {
            silent = true;
            noremap = true;
            desc = "Prev buffer (Barbar)";
          };
        }

        #---------------------------------------------------------------------------
        # PLUGIN: Oil - File Explorer
        #---------------------------------------------------------------------------
        {
          mode = "n";
          key = "<leader>e";
          action = "<cmd>Oil<cr>";
          options = {
            silent = true;
            noremap = true;
            desc = "Open Oil file explorer";
          };
        }
        # Fallback to netrw
        {
          mode = "n";
          key = "<leader>E";
          action = "<cmd>Explore<cr>";
          options = {
            silent = true;
            noremap = true;
            desc = "Open netrw Explore (fallback)";
          };
        }

        #---------------------------------------------------------------------------
        # PLUGIN: Tagbar
        #---------------------------------------------------------------------------
        {
          mode = "n";
          key = "<C-g>";
          action = ":TagbarToggle<cr>";
          options = {
            silent = true;
            desc = "Toggle Tagbar";
          };
        }

        #---------------------------------------------------------------------------
        # PLUGIN: Trouble
        #---------------------------------------------------------------------------
        {
          mode = "n";
          key = "<leader>T";
          action = ":Trouble<CR>";
          options = {
            silent = true;
            noremap = true;
            desc = "Open trouble window";
          };
        }

        #---------------------------------------------------------------------------
        # FILE OPERATIONS
        #---------------------------------------------------------------------------
        {
          mode = "n";
          key = "<leader>w";
          action = "<cmd>up<cr>";
          options = {
            silent = true;
            noremap = true;
            desc = "Update file";
          };
        }
        {
          mode = "n";
          key = "<leader>q";
          action = "<cmd>q<cr>";
          options = {
            silent = true;
            noremap = true;
            desc = "Close nvim";
          };
        }
        {
          mode = "n";
          key = "<leader>!";
          action = "<cmd>q!<cr>";
          options = {
            silent = true;
            noremap = true;
            desc = "Close nvim with force";
          };
        }
        {
          mode = "n";
          key = "<leader>s";
          action = ":vsplit<CR>";
          options = {
            silent = true;
            noremap = true;
            desc = "Vertical Split";
          };
        }

        #---------------------------------------------------------------------------
        # WINDOW NAVIGATION
        #---------------------------------------------------------------------------
        # Normal and visual mode
        {
          mode = ["n" "v"];
          key = "<C-h>";
          action = "<C-w>h";
          options = {
            silent = true;
            noremap = true;
            desc = "Move to the pane on the left";
          };
        }
        {
          mode = ["n" "v"];
          key = "<C-j>";
          action = "<C-w>j";
          options = {
            silent = true;
            noremap = true;
            desc = "Move to the pane below";
          };
        }
        {
          mode = ["n" "v"];
          key = "<C-k>";
          action = "<C-w>k";
          options = {
            silent = true;
            noremap = true;
            desc = "Move to the pane above";
          };
        }
        {
          mode = ["n" "v"];
          key = "<C-l>";
          action = "<C-w>l";
          options = {
            silent = true;
            noremap = true;
            desc = "Move to the pane on the right";
          };
        }
        # Terminal and insert mode
        {
          mode = ["t" "i"];
          key = "<C-h>";
          action = "<C-\\><C-N><C-w>h";
          options = {
            silent = true;
            noremap = true;
            desc = "Move to the pane on the left (terminal/insert)";
          };
        }
        {
          mode = ["t" "i"];
          key = "<C-j>";
          action = "<C-\\><C-N><C-w>j";
          options = {
            silent = true;
            noremap = true;
            desc = "Move to the pane below (terminal/insert)";
          };
        }
        {
          mode = ["t" "i"];
          key = "<C-k>";
          action = "<C-\\><C-N><C-w>k";
          options = {
            silent = true;
            noremap = true;
            desc = "Move to the pane above (terminal/insert)";
          };
        }
        {
          mode = ["t" "i"];
          key = "<C-l>";
          action = "<C-\\><C-N><C-w>l";
          options = {
            silent = true;
            noremap = true;
            desc = "Move to the pane on the right (terminal/insert)";
          };
        }
        {
          mode = "t";
          key = "<Esc>";
          action = "<C-\\><C-n>";
          options = {
            silent = true;
            noremap = true;
            desc = "Exit terminal mode";
          };
        }

        #---------------------------------------------------------------------------
        # MOVEMENT (NO PLUGINS)
        #---------------------------------------------------------------------------
        {
          mode = ["n" "v"];
          key = "H";
          action = "^";
          options = {
            silent = true;
            noremap = true;
            desc = "Start of the line";
          };
        }
        {
          mode = ["n" "v"];
          key = "L";
          action = "$";
          options = {
            silent = true;
            noremap = true;
            desc = "End of the line";
          };
        }
        {
          mode = "n";
          key = "J";
          action = "6j";
          options = {
            silent = true;
            noremap = true;
            desc = "6 lines down";
          };
        }
        {
          mode = "n";
          key = "K";
          action = "6k";
          options = {
            silent = true;
            noremap = true;
            desc = "6 lines up";
          };
        }

        #---------------------------------------------------------------------------
        # CLIPBOARD & REGISTERS
        #---------------------------------------------------------------------------
        {
          mode = ["n" "v"];
          key = "<leader>y";
          action = "\"+y";
          options = {
            silent = true;
            noremap = true;
            desc = "System clipboard yank";
          };
        }
        {
          mode = ["n" "v"];
          key = "<leader>Y";
          action = "\"+Y";
          options = {
            silent = true;
            noremap = true;
            desc = "System clipboard Yank";
          };
        }
        {
          mode = ["n" "v"];
          key = "<leader>p";
          action = "\"+]p";
          options = {
            silent = true;
            noremap = true;
            desc = "System clipboard put & indent";
          };
        }
        {
          mode = ["n" "v"];
          key = "<leader>P";
          action = "\"+]P";
          options = {
            silent = true;
            noremap = true;
            desc = "System clipboard Put & indent";
          };
        }
        {
          mode = ["n" "v"];
          key = "p";
          action = "]p";
          options = {
            silent = true;
            noremap = true;
            desc = "put with indent";
          };
        }
        {
          mode = ["n" "v"];
          key = "P";
          action = "]P";
          options = {
            silent = true;
            noremap = true;
            desc = "Put with indent";
          };
        }
        {
          mode = "x";
          key = "p";
          action = "\"_dP";
          options = {
            silent = true;
            noremap = true;
            desc = "Put without yanking replaced text";
          };
        }

        #---------------------------------------------------------------------------
        # MISC
        #---------------------------------------------------------------------------
        {
          mode = "n";
          key = "<C-v>";
          action = "<C-v>";
          options = {
            silent = true;
            noremap = true;
            desc = "Block visual mode";
          };
        }
        {
          mode = "n";
          key = "q";
          action = "q";
          options = {
            silent = true;
            noremap = true;
            desc = "Recording macros";
          };
        }
      ];
    };

    kitty = {
      enable = true;
      shellIntegration.enableFishIntegration = true;
      settings = {
        confirm_os_window_close = -0;
        copy_on_select = true;
        clipboard_control = "write-clipboard read-clipboard write-primary read-primary";
      };
      font = {
        size = 16.0;
        name = "JetBrainsMono Nerd Font";
      };
    };

    tmux = {
      enable = true;
      # prefix = "C-s";
      mouse = true;
      baseIndex = 1; # Start at 1
      # keyMode = "vi";
      extraConfig = ''
        set -g default-command ${pkgs.fish}/bin/fish

        # remappa " og % í þægilegri takka
        bind i split-window -h
        bind u split-window -v

        set -g status-position top
      '';
      plugins = with pkgs.tmuxPlugins; [
        # cpu
        tmux-fzf
        vim-tmux-navigator
        yank
        sensible
      ];
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        add_newline = false;
        command_timeout = 1000;
        scan_timeout = 3;
      };
    };

    #
    # File Navigation and Management
    #

    eza = {
      enable = true;
      enableFishIntegration = true;
      git = true;
      icons = "auto";
    };

    yazi = {
      enable = true;
      enableFishIntegration = true;
    };

    fd = {
      enable = true;
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = [
        "--cmd"
        "z"
      ];
    };

    ripgrep = {
      enable = true;
      arguments = [
        "--follow"
        "--pretty"
        "--hidden"
        "--smart-case"
      ];
    };

    bat = {
      enable = true;
    };

    #
    # Shell Enhancements
    #

    atuin = {
      enable = true;
      settings = {
        exit_mode = "return-query";
        keymap_mode = "auto";
        enter_accept = true;
        update_check = false;
        filter_mode = "directory";
        workspaces = true;

        stats.common_prefix = [
          "sudo"
          "time"
        ];
      };
    };

    #
    # Dev Tools
    #

    git = {
      enable = true;
      ignores = ["*.swp"];
      userName = "saumavel";
      userEmail = "saumavel@gmail.com";
      lfs.enable = true;
      delta.enable = true;
      aliases = {
        co = "checkout";
        cm = "commit";
        st = "status";
        br = "branch";
        df = "diff";
        lg = "log";
        pl = "pull";
        ps = "push";
      };
      extraConfig = {
        init.defaultBranch = "main";
        core.autocrlf = "input";
        pull.rebase = true;
        rebase.autoStash = true;
        url."ssh://git@github.com/".insteadOf = "https://github.com/";
      };
    };

    lazygit = {
      enable = true;
      settings = {
        git.paging.pager = "${pkgs.diff-so-fancy}/bin/diff-so-fancy";
        git.truncateCopiedCommitHashesTo = 40;
        gui = {
          language = "en";
          mouseEvents = false;
          sidePanelWidth = 0.3;
          mainPanelSplitMode = "flexible";
          showFileTree = true;
          nerdFontsVersion = 3;
          commitHashLength = 6;
          showDivergenceFromBaseBranch = "arrowAndNumber";
          skipDiscardChangeWarning = true;
        };
        quitOnTopLevelReturn = true;
        disableStartupPopups = true;
        promptToReturnFromSubprocess = false;
        keybinding.files.commitChangesWithEditor = "<disabled>";
        # Classhing with tmux keybindngs
        keybinding.commits.moveDownCommit = "<c-J>";
        keybinding.commits.moveUpCommit = "<c-K>";
        keybinding.commits.openLogMenu = "<c-L>";
        customCommands = [
          {
            key = "C";
            command = ''git commit -m "{{ .Form.Type }}{{if .Form.Scopes}}({{ .Form.Scopes }}){{end}}: {{ .Form.Description }}" -m "{{ .Form.LongDescription }}"'';
            description = "commit with commitizen and long description";
            context = "global";
            prompts = [
              {
                type = "menu";
                title = "Select the type of change you are committing.";
                key = "Type";
                options = [
                  {
                    name = "Feature";
                    description = "a new feature";
                    value = "feat";
                  }
                  {
                    name = "Fix";
                    description = "a bug fix";
                    value = "fix";
                  }
                  {
                    name = "Chores";
                    description = "Other changes that don't modify src or test files";
                    value = "chore";
                  }
                  {
                    name = "Documentation";
                    description = "Documentation only changes";
                    value = "docs";
                  }
                  {
                    name = "Styles";
                    description = "Changes that affect white-space, formatting, missing semi-colons, etc";
                    value = "style";
                  }
                  {
                    name = "Code Refactoring";
                    description = "Neither fixes a bug nor adds a feature";
                    value = "refactor";
                  }
                  {
                    name = "Performance Improvements";
                    description = "Improves performance";
                    value = "perf";
                  }
                  {
                    name = "Tests";
                    description = "Adding missing tests or correting existing tests";
                    value = "test";
                  }
                  {
                    name = "Builds";
                    description = "Build system or external dependencies";
                    value = "build";
                  }
                  {
                    name = "Continuous Integration";
                    description = "CI configuration files and scripts";
                    value = "ci";
                  }
                  {
                    name = "Reverts";
                    description = "Reverts a previous commit";
                    value = "revert";
                  }
                ];
              }
              {
                type = "input";
                title = "Enter the scope(s) of this change.";
                key = "Scopes";
              }
              {
                type = "input";
                title = "Enter the short description of the change.";
                key = "Description";
              }
              {
                type = "input";
                title = "Enter a longer description of the change (optional).";
                key = "LongDescription";
              }
            ];
          }
          {
            key = "O";
            description = "open repo in GitHub";
            command = "gh repo view --web";
            context = "global";
            loadingText = "Opening GitHub repo in browser...";
          }
        ];
      };
    };

    direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true; # Adds FishIntegration automatically
      config.warn_timeout = "30m";
      stdlib = ''
        # Avoid cluttering project directories which often conflicts with tooling, e.g., `mix`
        # https://github.com/direnv/direnv/wiki/Customizing-cache-location
        # Centralize direnv layouts in $HOME/.cache/direnv/layouts
        : ''${XDG_CACHE_HOME:=$HOME/.cache}
        declare -A direnv_layout_dirs
        direnv_layout_dir() {
          echo "''${direnv_layout_dirs[$PWD]:=$(
            echo -n "$XDG_CACHE_HOME"/direnv/layouts/
            echo -n "$PWD" | shasum | cut -d ' ' -f 1
          )}"
        }
      '';
    };

    ssh = {
      enable = true;
    };
  };

  # NOTE: Use this to add packages available everywhere on your system
  # $search nixpkgs {forrit}
  # https://search.nixos.org/packages
  home.packages = with pkgs; [
    #
    # MISC
    #
    cachix

    #
    # APPLICATIONS
    #

    # Browsers
    qutebrowser

    #
    # DEV TOOLS
    #

    # Programming Languages and Build Tools
    go
    cargo
    gcc
    cmake
    ninja
    ccache
    zig
    # For Mason/nix
    alejandra
    # Python formatter
    black
    # JavaScript/TypeScript/HTML/CSS/JSON/YAML/Markdown formatter
    nodePackages.prettier
    # Lua formatter
    stylua
    # C/C++ formatter
    clang-tools

    # Version Control and Collaboration
    gh
    delta

    # Code Editors & IDE
    # neovim
    tree-sitter

    # Database
    postgresql_16

    #
    # TERMINAL UTILITIES
    #

    # system information and monitoring
    neofetch
    btop
    pstree

    # File transfer and networking
    wget
    zip
    magic-wormhole-rs

    #
    # UTILITIES
    #

    # image processing
    imagemagick

    # pdf nvim
    ghostscript # For image rendering in nvim
    tectonic # for latex math
    mermaid-cli # Generation of diagrams from text in a similar manner as markdown

    # Documentation and help
    tldr

    # System integration
    desktop-file-utils
    xdg-utils

    # security and network tools
    nmap
    inetutils

    # Hardware and Device tools
    dfu-util

    # Virtualization
    utm
  ];
}
