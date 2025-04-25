# Do not show any greeting
set fish_greeting

# Ensure Nix-installed GCC and binaries come first
# Note: Adjust this if needed, but adding Nix paths first is common
set -q PATH; or set PATH '' # Ensure PATH exists before prepending
set -gx PATH /Users/saumavel/.nix-profile/bin /nix/var/nix/profiles/default/bin /run/current-system/sw/bin $PATH

# Add ~/.local/bin early
set -q PATH; or set PATH '' # Ensure PATH exists before prepending
set -gx PATH "$HOME/.local/bin" $PATH

# SSH AGENT & AUTO SSH KEY ADD
if test -z "$SSH_AUTH_SOCK"
    set -gx SSH_AUTH_SOCK (ssh-agent -c | awk '/SSH_AUTH_SOCK/ {print $3}' | sed 's/;//')
end

# Attempt to add key, suppress errors if already added or agent not fully ready
ssh-add -l >/dev/null; or command ssh-add ~/.ssh/id_ed25519 >/dev/null 2>&1

# HOME MANAGER & DARWIN SYSTEM PATHS
# Using fish_add_path is idempotent, safer than manual set -gx PATH ... $PATH here
# Consider if this is redundant with the explicit Nix paths added earlier
fish_add_path --prepend /run/current-system/sw/bin

# HOMEBREW CONFIGURATION
if test -d /opt/homebrew
    set -gx HOMEBREW_PREFIX /opt/homebrew
    set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
    set -gx HOMEBREW_REPOSITORY /opt/homebrew
    set -q PATH; or set PATH '' # Ensure PATH exists before prepending
    set -gx PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH
    set -q MANPATH; or set MANPATH ''
    set -gx MANPATH /opt/homebrew/share/man $MANPATH
    set -q INFOPATH; or set INFOPATH ''
    set -gx INFOPATH /opt/homebrew/share/info $INFOPATH
end

# ADDITIONAL TOOLS (Composer, Java, etc.)
# Ensure PATH exists before prepending
set -q PATH; or set PATH ''
set -gx PATH /Users/saumavel/.local/share/nvim/lazy/mason.nvim/lua/mason-core/managers/composer /Users/saumavel/bin $PATH
set -q PATH; or set PATH ''
set -gx PATH /Users/saumavel/.m2/wrapper/dists/apache-maven-3.9.7-bin/3k9n615lchs6mp84v355m633uo/apache-maven-3.9.7/bin $PATH

# ALIASES FOR NIX (Consider moving these to shellAliases in home.nix)
alias gcc '/Users/saumavel/.nix-profile/bin/gcc'
alias g++ '/Users/saumavel/.nix-profile/bin/g++'
alias cpp '/Users/saumavel/.nix-profile/bin/cpp'

# Add any other custom functions or settings from your old interactiveShellInit here
# e.g., Atuin bindings, Vi mode settings if they were there.
