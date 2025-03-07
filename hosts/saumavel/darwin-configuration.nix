{
  inputs,
  flake,
  pkgs,
  ...
}: let
  user = "saumavel";
in rec {
  imports = [
    inputs.home-manager.darwinModules.home-manager
    inputs.nix-homebrew.darwinModules.nix-homebrew
    flake.modules.darwin.common
    flake.modules.common.common
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

  nix-homebrew = {
    inherit user;
    enable = true;
    mutableTaps = false;
    taps = with inputs; {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
      "homebrew/homebrew-bundle" = homebrew-bundle;
    };
  };

  homebrew = {
    enable = true;
    taps = builtins.attrNames nix-homebrew.taps;
    brews = [
      "nvm"
      "node"
      "clang-format"
      "hashcat"
      # "openvpn"
      "qemu"
      "luarocks"
    ];
    # NOTE: Here you can install packages from brew
    # https://formulae.brew.sh
    casks = [
      # MEGA UTILITIES
      "raycast"
      "alt-tab"
      "karabiner-elements"
      "homerow"

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
      "discord"

      # FUN
      "bitwig-studio"
      "plex"
      "yt-music"

      # SCHOOL
      # "openvpn-connect"
      # "vnc-viewer"
    ];
    # NOTE: Here you can install packages from the Mac App Store
    masApps = {
      # `nix run nixpkgs #mas -- search <app name>`
      "Keynote" = 409183694;
      "Pages" = 409201541;
    };
  };

  home-manager.users.${user}.imports = [flake.modules.home.saumavel];

  # Enable tailscale. We manually authenticate when we want with out or delete all of this.
  services.tailscale.enable = true;
}
