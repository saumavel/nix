{ pkgs, perSystem }:
pkgs.mkShell {
  # Add build dependencies
  packages = [ perSystem.nix-darwin.darwin-rebuild ];

  # Add environment variables
  env = { };

  # Load custom bash code
  shellHook = '''';
}
