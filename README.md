# Nix Configuration

Unified flake-based Nix configuration for macOS (home-manager only), NixOS, and WSL.

## Structure

- **`mac/`** - macOS home-manager configuration
- **`nixos/`** - NixOS system configuration
- **`wsl/`** - WSL NixOS configuration
- **`modules/`** - Shared configuration modules (git, zsh, tmux, shell, nvim)
- **`flake.nix`** - Root flake managing all systems

## Installation

### macOS (Home Manager)

1. Clone the repo:
   ```bash
   git clone <repo-url> ~/git/dotfiles-nix
   cd ~/git/dotfiles-nix
   ```

2. Install home-manager if not already installed:
   ```bash
   nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
   nix-channel --update
   nix-shell '<home-manager>' -A install
   ```

3. Apply configuration:
   ```bash
   home-manager switch --flake .#"mvaldes@mac"
   ```

### NixOS

1. Clone the repo:
   ```bash
   git clone <repo-url> ~/git/dotfiles-nix
   ```

2. Create symlink to `/etc/nixos`:
   ```bash
   sudo ln -s ~/git/dotfiles-nix /etc/nixos
   ```

3. Test the configuration:
   ```bash
   sudo nixos-rebuild test --flake /etc/nixos#nixos
   ```

4. If successful, apply permanently:
   ```bash
   sudo nixos-rebuild switch --flake /etc/nixos#nixos
   ```

### WSL

1. Clone the repo:
   ```bash
   git clone <repo-url> ~/git/dotfiles-nix
   ```

2. Create symlink to `/etc/nixos`:
   ```bash
   sudo ln -s ~/git/dotfiles-nix /etc/nixos
   ```

3. Test the configuration:
   ```bash
   sudo nixos-rebuild test --flake /etc/nixos#wsl
   ```

4. If successful, apply permanently:
   ```bash
   sudo nixos-rebuild switch --flake /etc/nixos#wsl
   ```

## Usage

### macOS
```bash
# Update configuration
cd ~/git/dotfiles-nix
home-manager switch --flake ".#mvaldes@mac" --impure

# Update flake inputs
nix flake update

# Check what will change
home-manager build --flake ".#mvaldes@mac"
```

### NixOS
```bash
# Update configuration
sudo nixos-rebuild switch --flake /etc/nixos#nixos

# Update flake inputs
cd /etc/nixos && sudo nix flake update

# Test configuration without applying
sudo nixos-rebuild test --flake /etc/nixos#nixos
```

### WSL
```bash
# Update configuration
sudo nixos-rebuild switch --flake /etc/nixos#wsl

# Update flake inputs
cd /etc/nixos && sudo nix flake update

# Test configuration without applying
sudo nixos-rebuild test --flake /etc/nixos#wsl
```

## Notes

- **Username**: Default username is `mvaldes` - update in each system's configuration file if needed
- **macOS External Dependencies**: The Mac config references dotfiles at `~/git/dotfiles/`. To build without `--impure`, you'll need to either:
  - Move those files into this repo under a `dotfiles/` directory
  - Use `--impure` flag: `home-manager switch --flake .#"mvaldes@mac" --impure`
- **Shared Modules**: All systems share common configuration modules for git, zsh, tmux, and shell programs
