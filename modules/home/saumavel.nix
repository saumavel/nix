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

  xdg.enable = true; # Needed for fish interactiveShellInit hack
  home.file.".config/karabiner/karabiner.json".source = config.lib.file.mkOutOfStoreSymlink ./karabiner.json; # Hyper-key config
  home.file.".hushlogin".text = ""; # Get rid of "last login" stuff

      # NOTE: START HERE: Install packages that are only available in your user environment.
      # https://home-manager-options.extranix.com/
      programs = {
        alacritty.enable = true;

        yazi = {
          enable = true;
          enableFishIntegration = true;
        };

        kitty = {
          enable = true;
          shellIntegration.enableFishIntegration = true;
          extraConfig = ''
            macos_quit_when_window_closed no
          '';
        };

        zathura.enable = true;

        tmux = {
          enable = true;
          extraConfig = ''
            unbind r
            bind r source-file ~/.tmux.conf
            
            set -g prefix C-s
            
            set -g mouse on
            
            set -g base-index 1
            set -g pane-base-index 1
            
            # act like vim
            bind-key h select-pane -L
            bind-key j select-pane -D
            bind-key k select-pane -U
            bind-key l select-pane -R
            
            # remappa " og % í þægilegri takka
            bind i split-window -h
            bind u split-window -v
            
            set -g status-position top

            # List of plugins
            # set -g @plugin 'tmux-plugins/tpm'
            # set -g @plugin 'catppuccin/tmux'

            # # Catppuccin settings
            # set -g @catppuccin_window_left_separator ""
            # set -g @catppuccin_window_right_separator ""
            # set -g @catppuccin_window_middle_separator " █"
            # set -g @catppuccin_window_number_position "right"
            #
            # set -g @catppuccin_window_default_fill "number"
            # set -g @catppuccin_window_default_text "#W"
            #
            # set -g @catppuccin_window_current_fill "number"
            # set -g @catppuccin_window_current_text "#W"
            #
            # set -g @catppuccin_status_modules_right "directory session"
            # set -g @catppuccin_status_left_separator " "
            # set -g @catppuccin_status_right_separator ""
            # set -g @catppuccin_status_fill "icon"
            # set -g @catppuccin_status_connect_separator "no"
            #
            # set -g @catppuccin_directory_text "#{pane_current_path}"
            # Þarf að skoða þetta. Meikar ekki alveg sens. 
            # Initialize TMUX plugin manager (keep this line at the very bottom of .tmux.conf)
            run '~/.tmux/plugins/tpm/tpm'
            '';
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

        # zathura.enable = true;

        direnv = {
          enable = true;
          nix-direnv.enable = true; # Adds FishIntegration automatically
        };
        fish = {
          enable = true;
          interactiveShellInit = # bash
            ''
              # bind to ctrl-p in normal and insert mode, add any other bindings you want here too
              bind \cp _atuin_search
              bind -M insert \cp _atuin_search
              bind \cr _atuin_search
              bind -M insert \cr _atuin_search

              set -gx DIRENV_LOG_FORMAT ""

              function fish_user_key_bindings
                fish_vi_key_bindings
              end

              set fish_vi_force_cursor
              set fish_cursor_default     block      blink
              set fish_cursor_insert      line       blink
              set fish_cursor_replace_one underscore blink
              set fish_cursor_visual      block


              # Custom aliases for Git commands
              alias gst='git status'
              alias ga='git add'
              alias gcmsg='git commit -m'
              alias gp='git push'
              alias gl='git pull'
              alias gco='git checkout'
              alias gb='git branch'  
              alias ll='ls -la'
              # set -gx IDF_TOOLS_PATH "$HOME/esp/esp-idf"
            '';

          shellInit = # bash
            ''
              set fish_greeting # Disable greeting

              # done configurations
              set -g __done_notification_command 'notify send -t "$title" -m "$message"'
              set -g __done_enabled 1
              set -g __done_allow_nongraphical 1
              set -g __done_min_cmd_duration 8000

              # see https://github.com/LnL7/nix-darwin/issues/122
              set -ga PATH $HOME/.local/bin
              set -ga PATH /run/wrappers/bin
              set -ga PATH $HOME/.nix-profile/bin
              set -ga PATH /run/current-system/sw/bin
              set -ga PATH /nix/var/nix/profiles/default/bin

              # Adapt construct_path from the macOS /usr/libexec/path_helper executable for
              # fish usage;
              #
              # The main difference is that it allows to control how extra entries are
              # preserved: either at the beginning of the VAR list or at the end via first
              # argument MODE.
              #
              # Usage:
              #
              #   __fish_macos_set_env MODE VAR VAR-FILE VAR-DIR
              #
              #   MODE: either append or prepend
              #
              # Example:
              #
              #   __fish_macos_set_env prepend PATH /etc/paths '/etc/paths.d'
              #
              #   __fish_macos_set_env append MANPATH /etc/manpaths '/etc/manpaths.d'
              #
              # [1]: https://opensource.apple.com/source/shell_cmds/shell_cmds-203/path_helper/path_helper.c.auto.html .
              #
              function macos_set_env -d "set an environment variable like path_helper does (macOS only)"
                # noops on other operating systems
                if test $KERNEL_NAME darwin
                  set -l result
                  set -l entries

                  # echo "1. $argv[2] = $$argv[2]"

                  # Populate path according to config files
                  for path_file in $argv[3] $argv[4]/*
                    if [ -f $path_file ]
                      while read -l entry
                        if not contains -- $entry $result
                          test -n "$entry"
                          and set -a result $entry
                        end
                      end <$path_file
                    end
                  end

                  # echo "2. $argv[2] = $result"

                  # Merge in any existing path elements
                  set entries $$argv[2]
                  if test $argv[1] = "prepend"
                    set entries[-1..1] $entries
                  end
                  for existing_entry in $entries
                    if not contains -- $existing_entry $result
                      if test $argv[1] = "prepend"
                        set -p result $existing_entry
                      else
                        set -a result $existing_entry
                      end
                    end
                  end

                  # echo "3. $argv[2] = $result"

                  set -xg $argv[2] $result
                end
              end
              macos_set_env prepend PATH /etc/paths '/etc/paths.d'

              set -ga MANPATH $HOME/.local/share/man
              set -ga MANPATH $HOME/.nix-profile/share/man
              if test $KERNEL_NAME darwin
                set -ga MANPATH /opt/homebrew/share/man
              end
              set -ga MANPATH /run/current-system/sw/share/man
              set -ga MANPATH /nix/var/nix/profiles/default/share/man
              macos_set_env append MANPATH /etc/manpaths '/etc/manpaths.d'

              if test $KERNEL_NAME darwin
                set -gx HOMEBREW_PREFIX /opt/homebrew
                set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
                set -gx HOMEBREW_REPOSITORY /opt/homebrew
                set -gp INFOPATH /opt/homebrew/share/info
              end
            '';
        };

        ssh.enable = true;

        git = {
          enable = true;
          ignores = [ "*.swp" ];
          userName = "saumavel";
          userEmail = "kari@genkiinstruments.com";
          lfs.enable = true;
          extraConfig = {
            init.defaultBranch = "main";
            core.autocrlf = "input";
            pull.rebase = true;
            rebase.autoStash = true;
          };
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
   # https://search.nixos.org/packages
  home.packages = with pkgs; [
    neofetch
    btop
    wget
    zip
    magic-wormhole-rs
    gh
    neovim
    kitty
    # Kári byrjuaður að krukka eins og einhver motherfokker!
    vscode
    python3
    zathura
    
    cmake
    ninja
    dfu-util
    ccache
    #zed-editor
    tree-sitter
    ];
}
