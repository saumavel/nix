# Do not show any greeting
set fish_greeting

set -g SHELL ${pkgs.fish}/bin/fish

# Source Home Manager variables for Fish
if test -e $HOME/.nix-profile/etc/profile.d/hm-session-vars.fish
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
alias inv 'nvim $(fzf -m --preview="bat --color=always {}")'
