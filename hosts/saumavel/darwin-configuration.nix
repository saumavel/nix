{
  inputs,
  flake,
  pkgs,
  ...
}:
let
  user = "saumavel";
in
rec {
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
      "luarocks"
      "findent"
      "node"
      "imagemagick"
	  "clang-format"
	  "hashcat"
	  "openvpn"
    ];
    # NOTE: Here you can install packages from brew
    # https://formulae.brew.sh
    casks = [
      "raycast"
      "arc"
      "bitwig-studio"
      "karabiner-elements"
      "transnomino"
      "julia"
      "chatgpt"
      "cheatsheet"
      "plex"
      "alt-tab"
      "kitty"
      "alacritty"
      "postman"
      "messenger"
      "discord"
      "slack"
      "logi-options+"
      "the-unarchiver"
      "keyboardcleantool"
      "qutebrowser"
      "obsidian"
      "linear-linear"
      "ghostty"
	  "virtualbox"
	  "yt-music"
    ];
    # NOTE: Here you can install packages from the Mac App Store
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
