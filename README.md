# Nix Configuration for couple systems.

## NIXOS
Composed of:
- configuration.nix
- hardware-configuration.nix
- home.nix

Configurations can share the specifics for apps like: i3, tmux, nvim, rofi, etc.
Those can be found in the configuration and modules folders


## WSL
Standalone setup for nixos in wsl, composed of:
- flake.nix
  - home-wsl.nix
  - configuration.nix
