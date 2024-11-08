# saumavel 🪡

## Important stuff

* Search for `NOTE` to find places to install packages.
* Update packages using `nix flake update`
* Switch to new system `darwin-rebuild switch --flake ~/saumavel`

## Folder structure

* `devshells/` for devshells.
* `hosts/` for machine configurations.
* `lib/` for Nix functions.
* `modules/` for NixOS and other modules.
* `packages/` for packages.
* `templates/` for flake templates.

* `devshell.nix` for the default devshell
* `formatter.nix` for the default formatter
* `package.nix` for the default package

For further information read [blueprint's documentation](https://github.com/numtide/blueprint/blob/main/docs/folder-structure.md).
