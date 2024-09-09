{
  inputs,
  flake,
  ...
}:
let
  user = "genki";
in
rec {
  imports = [
    inputs.home-manager.darwinModules.home-manager
    inputs.nix-homebrew.darwinModules.nix-homebrew
    flake.modules.darwin.common
    flake.modules.common.common
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  networking.hostName = "d";

  users.users.${user} = {
    isHidden = false;
    home = "/Users/${user}";
    name = "${user}";
    shell = "/run/current-system/sw/bin/fish";
  };

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

  # NOTE: Here you can install packages from brew
  homebrew = {
    enable = true;
    taps = builtins.attrNames nix-homebrew.taps;
    casks = [
      "raycast"
      "arc"
    ];
    masApps = {
      # `nix run nixpkgs#mas -- search <app name>`
      "Keynote" = 409183694;
    };
  };

  programs.fish.enable = true;

  home-manager.users.${user}.imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
    flake.modules.home.daniel
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Enable tailscale. We manually authenticate when we want with out or delete all of this.
  services.tailscale.enable = true;
}
