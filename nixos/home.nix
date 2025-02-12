{  pkgs, ... }: {
  home.username = "mvaldes";
  home.homeDirectory = "/home/mvaldes";
  home.stateVersion = "24.05";
  home.file = {
    ".ssh/config" = {
      source = /home/mvaldes/git/dotfiles/.ssh/config;
    };
    ".local/bin" = {
      source = /home/mvaldes/git/dotfiles/scripts;
      target = "/home/mvaldes/.local/bin";
      recursive = true;
    };
    ".aws/config" = {
      source = /home/mvaldes/git/dotfiles/.aws/config;
    };
    ".config/wezterm" = {
      source = /home/mvaldes/git/dotfiles/.config/wezterm;
      target = "/home/mvaldes/.config/wezterm";
    };
    ".config/waybar" = {
      source = /home/mvaldes/git/dotfiles-nix/config/waybar;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    LC_ALL = "C.UTF-8";
    PATH = "$PATH:$HOME/.local/bin";
  };

  programs.home-manager.enable = true;
  programs.zsh.enable = true;

  imports = [
    /home/mvaldes/git/dotfiles-nix/modules/git.nix
    /home/mvaldes/git/dotfiles-nix/modules/zsh.nix
    /home/mvaldes/git/dotfiles-nix/modules/shell.nix
    /home/mvaldes/git/dotfiles-nix/modules/tmux.nix
  ];

  #Pkgs installed via os
  # steam, spotify, discord, i3, rofi, lutris, obs, obsidian
  home.packages = with pkgs; [
    # Utilities
    tldr
    htop
    sox
    screenkey
    jq
    tree
    fd
    ripgrep
    kubectl
    kubernetes-helm
    doppler
    ncdu
    nixpkgs-fmt
    stern
    docker-compose
    dig
    feh
    bat
    bitwarden-cli
    brightnessctl
    playerctl
    tokyonight-gtk-theme
    hyprshot
    nerdfetch
    go-task
  ];
}
