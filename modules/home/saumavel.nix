{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim    

	# færa annað!
    ./nixvim/autocommands.nix
    ./nixvim/completion.nix
    ./nixvim/keymappings.nix
    ./nixvim/options.nix
	./nixvim/todo.nix
	./nixvim/plugins/git.nix
	./nixvim/plugins/lint.nix
	./nixvim/plugins/lsp.nix
	./nixvim/plugins/lualine.nix
	./nixvim/plugins/misc_plugins.nix
    ./nixvim/plugins/oil.nix
	./nixvim/plugins/telescope.nix
    ./nixvim/plugins/completion.nix
	# ./nixvim/plugins/treesitter.nix
	# færa annað!

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
      ".local/bin/zathura-nix" = {
        executable = true;
        text = ''
          #!/bin/sh
          # Improved zathura-nix script for M1 Mac
          # Preserve all arguments exactly as passed
          nix-shell -p zathura --run "zathura \"$@\""
        '';
      };
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
      # Zathura PDF viewer configuration
      "zathura/zathurarc".source = ./config/zathurarc;
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
      "application/pdf" = "org.pwmt.zathura.desktop";
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
        zathura = "$HOME/.local/bin/zathura-nix";
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

    nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      luaLoader = {
        enable = true;
      };

      colorschemes = {
        catppuccin = {
          enable = true;
        };
      };

      plugins = {
        lualine.enable = true;
        lazygit.enable = true;
      };
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

    thefuck = {
      enable = true;
      enableFishIntegration = true;
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

    # File management and navigation
    fzf
    fd
    eza
    bat
    ripgrep

    # system information and monitoring
    neofetch
    btop
    pstree

    # File transfer and networking
    wget
    zip
    magic-wormhole-rs

    # shell enhancements
    thefuck

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
