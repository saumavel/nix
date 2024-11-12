{
  pkgs,
  config,
  ...
}:
{
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "23.05";

  # THEME
  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  xdg = {
    enable = true;
    mimeApps.defaultApplications = {
      "text/html" = "arc.desktop";
      "text/plain" = "nvim.desktop";
      "application/pdf" = "zathura.desktop";
    };
  };

  # Needed for fish interactiveShellInit hack
  home.file.".config/karabiner/karabiner.json".source = config.lib.file.mkOutOfStoreSymlink ./karabiner.json; # Hyper-key config
  home.file.".hushlogin".text = ""; # Get rid of "last login" stuff

  # NOTE: START HERE: Install packages that are only available in your user environment.
  # https://home-manager-options.extranix.com/
  programs = {
    alacritty = {
      enable = true;
      settings = {
        font = {
          normal = {
            family = "JetBrainsMono Nerd Font"; # Set the font family correctly
            style = "Regular"; # Optional: specify style if needed
          };
          size = 20;
        };
        keyboard.bindings = [
          {
            key = "K";
            mods = "Control";
            chars = "\\u000c";
          }
        ];
      };
    };

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

    kitty = {
      enable = true;
      shellIntegration.enableFishIntegration = true;
      settings = {
        confirm_os_window_close = -0;
        copy_on_select = true;
        clipboard_control = "write-clipboard read-clipboard write-primary read-primary";
      };
      font = {
        size = 20.0;
        name = "JetBrainsMono Nerd Font";
      };
    };

    ripgrep.enable = true;

    fd.enable = true;

    fzf = {
      enable = true;
      enableFishIntegration = true;
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

    lazygit.enable = true;
    lazygit.settings.gui.skipDiscardChangeWarning = true;

    zoxide.enable = true;
    zoxide.enableFishIntegration = true;

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

    fish = {
      enable = true;
      interactiveShellInit = # bash
        ''
          # Do not show any greeting
          set fish_greeting

          set -g SHELL ${pkgs.fish}/bin/fish

          # Darwin openssh does not support FIDO2. Overwrite PATH with binaries in current system.
          fish_add_path --path --move /run/current-system/sw/bin

          # Homebrew
          if test -d /opt/homebrew
              set -gx HOMEBREW_PREFIX /opt/homebrew
              set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
              set -gx HOMEBREW_REPOSITORY /opt/homebrew
              set -q PATH; or set PATH ""
              set -gx PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH
              set -q MANPATH; or set MANPATH ""
              set -gx MANPATH /opt/homebrew/share/man $MANPATH
              set -q INFOPATH; or set INFOPATH ""
              set -gx INFOPATH /opt/homebrew/share/info $INFOPATH
          end

          # Add ~/.local/bin
          set -q PATH; or set PATH ""
          set -gx PATH "$HOME/.local/bin" $PATH

          # PATH for composer, IDF, python, composer
          set -gx PATH /Users/saumavel/.local/share/nvim/lazy/mason.nvim/lua/mason-core/managers/composer /Users/saumavel/bin /Library/Developer/CommandLineTools/usr/bin $PATH
          set -gx IDF_TOOLS_PATH "$HOME/esp/esp-idf"
        '';
    };

    ssh.enable = true;

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
      };
    };

    bat.enable = true;

    thefuck = {
      enable = true;
      enableFishIntegration = true;
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
  };

  # NOTE: Use this to add packages available everywhere on your system
  # $search nixpkgs {forrit}
  # https://search.nixos.org/packages
  home.packages = with pkgs; [
    neofetch
    btop
    wget
    zip
    magic-wormhole-rs
    gh
    neovim
    ripgrep
    fd
    fzf
    go
    cargo
    vscode
    obsidian
    cmake
    ninja
    dfu-util
    ccache
    tree-sitter
    zathura
    xdg-utils
    desktop-file-utils
    tldr
    eza
    bat
    delta
    thefuck
    # kitty
    # alacritty
    # imagemagick
  ];
}
