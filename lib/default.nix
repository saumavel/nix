_: {
  nvim-lsp-packages =
    { pkgs, ... }:
    with pkgs;
    [
      #
      # LANGUAGE SERVERS & LINTERS
      # These provide code intelligence, diagnostics, and language support for various languages
      #

      # JavaScript/TypeScript
      nodejs # Required for Copilot and JS/TS tools
      nodePackages.bash-language-server # Bash language server
      vscode-langservers-extracted # JSON language server
      nodePackages.prettier # JavaScript/TypeScript/HTML/CSS/JSON/YAML/Markdown formatter
      vtsls # TypeScript language server
      emmet-language-server # HTML/CSS snippets and completion
      svelte-language-server # Svelte support

      # Python
      pyright # Python language server
      black # Python formatter
      ruff # Fast Python linter
      python3 # Required for sqlfluff and other Python tools

      # Go
      gopls # Go language server
      golangci-lint # Go linter

      # Rust
      rust-analyzer # Rust language server
      cargo # Rust package manager and build tool
      taplo # TOML language server
      taplo-lsp # Alternative TOML language server

      # Lua
      lua-language-server # Lua language server
      stylua # Lua formatter
      selene # Lua linter

      # Nix
      nil # Nix language server
      nixd # Alternative Nix language server
      nixfmt-rfc-style # Official Nix formatter (RFC style)
      alejandra # Alternative Nix formatter

      # Web Development
      tailwindcss-language-server # Tailwind CSS support

      # Infrastructure & DevOps
      terraform-ls # Terraform language server

      # Shell
      shellcheck # Shell script static analysis
      shfmt # Shell script formatter

      # C/C++
      clang-tools # C/C++ language server and formatter
      
      ninja # Fast build system
      ccache # Compiler cache
      stdenv.cc # Needed to compile and link nl and other packages

      # Markup & Data
      yaml-language-server # YAML language server
      marksman # Markdown language server
      sqlfluff # SQL linter and formatter

      # Other Languages
      elixir-ls # Elixir language server
      zls # Zig language server
      zig # Zig compiler

      # Text Tools
      typos-lsp # Spell checking language server
      typos # Spell checker

      #
      # GO DEVELOPMENT TOOLS
      # Specialized tools for Go development
      #
      go # Go compiler and tools
      delve # Go debugger
      ginkgo # Go testing framework
      gofumpt # Go formatter
      golines # Go formatter for long lines
      gomodifytags # Go tool for modifying struct tags
      gotests # Go test generator
      gotestsum # Go test runner with summary
      gotools # Additional Go tools
      govulncheck # Go vulnerability checker
      iferr # Go error handling generator
      impl # Go interface implementation generator

      #
      # EDITOR TOOLS & UTILITIES
      # Tools that enhance editor functionality
      #
      tree-sitter # Incremental parsing library
      ripgrep # Fast grep replacement
      fd # Fast find replacement
      fzf # Fuzzy finder
      lazygit # Git TUI
      xsel # For lazygit copy/paste to clipboard
      unzip # For unpacking extensions
      coreutils # Basic Unix utilities
      sqlite # For dadbod (database interface)

      #
      # DOCUMENT & DIAGRAM TOOLS
      # Tools for working with documents and diagrams
      #
      ghostscript # For image rendering in nvim
      mermaid-cli # Generation of diagrams from text
      # tectonic # For LaTeX math (disabled due to build issues)
    ]
    ++ lib.optional (stdenv.hostPlatform.system != "aarch64-linux") ast-grep;

  treesitter-grammars =
    { pkgs, ... }:
    with pkgs;
    let
      grammars = lib.filterAttrs (
        n: _: lib.hasPrefix "tree-sitter-" n
      ) vimPlugins.nvim-treesitter.builtGrammars;
      symlinks = lib.mapAttrsToList (
        name: grammar: "ln -s ${grammar}/parser $out/${lib.removePrefix "tree-sitter-" name}.so"
      ) grammars;
    in
    (runCommand "treesitter-grammars" { } ''
      mkdir -p $out
      ${lib.concatStringsSep "\n" symlinks}
    '').overrideAttrs
      (_: {
        passthru.rev = vimPlugins.nvim-treesitter.src.rev;
      });
  neovim =
    { pkgs, ... }:
    with pkgs;
    wrapNeovimUnstable neovim-unwrapped (
      neovimUtils.makeNeovimConfig {
        wrapRc = false;
        withRuby = false;
        # extraLuaPackages = ps: [ (ps.callPackage ./lua-tiktoken.nix { }) ];
      }
    );
}
