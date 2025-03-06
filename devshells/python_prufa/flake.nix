{
  description = "Python development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};

        # Customize your Python version and packages here
        pythonEnv = pkgs.python311.withPackages (ps:
          with ps; [
            # Development tools
            pip
            pytest
            black
            flake8
            mypy

            # Common libraries - add what you need
            numpy
            pandas
            requests

            # Add more packages as needed
          ]);
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pythonEnv
            pkgs.poetry # Optional: for dependency management
          ];

          # Set up environment variables if needed
          shellHook = ''
            echo "Python $(${pythonEnv}/bin/python --version)"
            echo "Welcome to your Python development environment!"

            # Create a .venv directory for tools that expect it
            [ ! -d .venv ] && mkdir -p .venv

            # Optional: activate a virtual environment feel
            export VIRTUAL_ENV=''${PWD}/.venv
            export PATH="''${PWD}/.venv/bin:$PATH"
          '';
        };
      }
    );
}
