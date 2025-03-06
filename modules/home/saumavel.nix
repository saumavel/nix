{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  imports = [inputs.catppuccin.homeManagerModules.catppuccin];
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "23.05";

  # THEME
  catppuccin = {
    enable = true;
    flavor = "mocha";
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

  # Needed for fish interactiveShellInit hack
  home.file.".hushlogin".text = ""; # Get rid of "last login" stuff

  home.file.".local/bin/zathura-nix" = {
    executable = true;
    text = ''
      #!/bin/sh
      nix-shell -p zathura --run "zathura $*"
    '';
  };

  # NOTE: START HERE: Install packages that are only available in your user environment.
  # https://home-manager-options.extranix.com/
  programs = {
    #
    # Shell and Terminal
    #

    fish = {
      enable = true;
      interactiveShellInit =
        # bash
        ''
          # Do not show any greeting
          set fish_greeting

          set -g SHELL ${pkgs.fish}/bin/fish

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

          # ADDITIONAL TOOLS (Composer, ESP-IDF, etc.)
          set -gx PATH /Users/saumavel/.local/share/nvim/lazy/mason.nvim/lua/mason-core/managers/composer /Users/saumavel/bin $PATH
          set -gx IDF_TOOLS_PATH "$HOME/esp/esp-idf"

          set -gx PATH /Users/saumavel/.m2/wrapper/dists/apache-maven-3.9.7-bin/3k9n615lchs6mp84v355m633uo/apache-maven-3.9.7/bin $PATH

          # ALIASES FOR NIX
          alias gcc "/Users/saumavel/.nix-profile/bin/gcc"
          alias g++ "/Users/saumavel/.nix-profile/bin/g++"
          alias cpp "/Users/saumavel/.nix-profile/bin/cpp"
          alias zathura "$HOME/.local/bin/zathura-nix"
        '';
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
      prefix = "C-s";
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
      plugins = with pkgs; [
        tmuxPlugins.cpu
        tmuxPlugins.tmux-fzf
        tmuxPlugins.vim-tmux-navigator
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
    };

    bat = {
      enable = true;
    };

    #
    # Shell Enhancements
    #
    atuin = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        exit_mode = "return-query";
        keymap_mode = "auto";
        prefers_reduced_motion = true;
        enter_accept = true;
        show_help = false;
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
      # userEmail = "kari@genkiinstruments.com";
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
      settings.gui.skipDiscardChangeWarning = true;
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
    # For Mason/nix
    alejandra

    # Version Control and Collaboration
    gh
    delta

    # Code Editors & IDE
    neovim
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
