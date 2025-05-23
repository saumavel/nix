{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    inputs.self.homeModules.nvim
    inputs.catppuccin.homeModules.catppuccin
  ];

  programs.mvim.nvimConfigSource = "/Users/saumavel/nix/home/nvim";
  # THEME
  catppuccin = {
    enable = true;
    flavor = "mocha";
    # See issues with IFD: https://github.com/catppuccin/nix?tab=readme-ov-file#-faq
    fzf.enable = false;
    starship.enable = false;
    cava.enable = false;
    gh-dash.enable = false;
    imv.enable = false;
    swaylock.enable = false;
    mako.enable = false;
    lazygit.enable = false;
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
    bash = {
      enable = true;
    };

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
        cppbuild = "g++ -std=c++17 -Wall -Wextra";
      };
      interactiveShellInit = lib.strings.concatStrings (
        lib.strings.intersperse "\n" [
          # Reads the content from the external file you created
          (builtins.readFile ./config/fish/config.fish)

          "set -g SHELL ${pkgs.fish}/bin/fish"
        ]
      );
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
      prefix = "C-a";
      mouse = true;
      baseIndex = 1; # Start at 1
      keyMode = "vi";
      extraConfig = ''
        set -g default-command ${pkgs.fish}/bin/fish

        # remappa " og % í þægilegri takka
        bind i split-window -h
        bind u split-window -v

        # alt H & L til að navigatea milli windows
        bind -n M-H previous-window
        bind -n M-L previous-window

        # Open panes in current directory
        bind '"' split-window -v -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"

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
        # command_timeout = 1000;
        command_timeout = 5000;
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
      ignores = [ "*.swp" ];
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
        # Clashing with tmux keybindings
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
    # DEVELOPMENT & VERSION CONTROL
    # Tools for development workflows and version control
    #
    gh # GitHub CLI for managing GitHub from the terminal
    delta # Enhanced git diff viewer with syntax highlighting
    cachix # Binary cache hosting service for Nix

    #
    # DATABASE TOOLS
    # Database servers and management tools
    #
    postgresql_16 # PostgreSQL database server

    #
    # SYSTEM MONITORING & INFORMATION
    # Tools for monitoring system performance and displaying system information
    #
    neofetch # System information tool with ASCII art display
    btop # Resource monitor with CPU, memory, disk, and network usage
    pstree # Display running processes as a tree

    #
    # FILE MANAGEMENT & NETWORKING
    # Tools for file operations and network connectivity
    #
    wget # Tool for retrieving files using HTTP, HTTPS, and FTP
    zip # File compression and packaging utility
    magic-wormhole-rs # Securely transfer files between computers
    nmap # Network discovery and security auditing utility
    inetutils # Collection of common network utilities (ping, telnet, etc.)

    #
    # MEDIA & DOCUMENT PROCESSING
    # Tools for working with images, documents, and media
    #
    imagemagick # Comprehensive suite for image manipulation and conversion

    #
    # SYSTEM INTEGRATION & UTILITIES
    # Tools that enhance system functionality and integration
    #
    desktop-file-utils # Command line utilities for working with desktop entries
    xdg-utils # Tools for desktop integration (xdg-open, xdg-mime, etc.)
    tldr # Simplified and community-driven man pages with practical examples
    dfu-util # Device firmware update utility for USB devices

    #
    # VIRTUALIZATION & EMULATION
    # Tools for running virtual machines and emulators
    #
    utm # Virtual machine manager for macOS (QEMU frontend)

    #
    # BROWSERS & WEB TOOLS
    # Web browsers and tools for web interaction
    #
    # qutebrowser # Keyboard-focused browser with a minimal GUI
  ];
}
