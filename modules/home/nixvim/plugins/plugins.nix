{ pkgs, config, lib, ... }:

{
  imports = [
    ./oil.nix
    ./tree-sitter.nix
    ./trouble.nix
    ./which-key.nix
    ./web-devicons.nix
    # Add other plugin files as needed
  ];
}
