{
  inputs,
  flake,
  pkgs,
  lib,
  ...
}:
let
  user = "saumavel";
in
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
    flake.modules.darwin.common
    flake.modules.common.common
  ];

  # Add the unfree configuration here
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "copilot.vim"
    ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  networking.hostName = "saumavel";

  users.users.${user} = {
    isHidden = false;
    home = "/Users/${user}";
    name = "${user}";
    shell = pkgs.fish;
  };

  # Fix nixbld group ID issue
  ids.gids.nixbld = 350;

  # Modified homebrew configuration to update but not remove packages
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true; # Update Homebrew and formulae
      upgrade = true; # Upgrade outdated packages
      cleanup = "none"; # Don't remove any packages not in the list
    };
    brews = [
      "nvm"
      "node"
      "clang-format"
      "hashcat"
      "qemu"
      "luarocks"
      "biber"
      "texlive"
      "xdotool"
    ];
    casks = [
      # MEGA UTILITIES
      "raycast"
      "alt-tab"
      "karabiner-elements"
      "shortcat"
      "screen-studio"

      # UTILITIES
      "keyboardcleantool"
      "logi-options+"
      "the-unarchiver"
      "postman"

      # TERMINALS
      "ghostty"
      "kitty"

      # WORK
      "obsidian"
      "slack"
      "linear-linear"

      # BROWSERS
      "arc"

      # CHAT
      "messenger"

      # FUN
      "bitwig-studio"
      "plex"

      # IDE´s
      "zed"
      "visual-studio-code"
    ];
    masApps = {
      # `nix run nixpkgs #mas -- search <app name>`
      "Keynote" = 409183694;
      "Pages" = 409201541;
    };
  };

  home-manager.users.${user}.imports = [ flake.modules.home.saumavel ];

  # Enable tailscale. We manually authenticate when we want with out or delete all of this.
  services.tailscale.enable = true;
}
