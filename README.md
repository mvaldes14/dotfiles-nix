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

# Installation
NixOS & WSL:
1. Clone the repo to your machine.
2. Make a link of the files `configuration, home, hardware-configuration, flake, modules, config` to `/etc/nixos/`

    If you are doing NIXOS:
    - `ln -s ~/<path-to-your-repo>/nixos/ /etc/nixos`

    If you are doing WSL:
    - `ln -s ~/<path-to-your-repo>/wsl/ /etc/nixos`
3. Modify the username if desired.
    - defaults to "nixos" watch -> `line 86, 94 & 98 in configuration.nix`
4. Once linked install the config `sudo nixos-rebuild test --impure`. Impure is needed since part of the configuration is outside of nix.
5. The initial install will download everything so give it time. If it doesn't error out then `sudo nixos-rebuild switch --impure`
