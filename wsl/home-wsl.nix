{ pkgs, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "24.05"; # Please read the comment before changing.
  home.file = {
    ".ssh/config" = {
      source = /home/nixos/git/dotfiles/.ssh/config;
    };
    ".local/bin" = {
      source = /home/nixos/git/dotfiles/scripts;
      target = "/home/nixos/.local/bin";
      recursive = true;
    };
    ".aws/config" = {
      source = /home/nixos/git/dotfiles/.aws/config;
    };
    ".config/wezterm" = {
      source = /home/nixos/git/dotfiles/.config/wezterm;
      target = "/home/nixos/.config/wezterm";
    };
    ".config/nvim" = {
      source = /home/nixos/git/dotfiles/.config/nvim;
      target = "/home/nixos/.config/nvim";
      recursive = true;
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
    /etc/nixos/modules/git.nix
    /etc/nixos/modules/zsh.nix
    /etc/nixos/modules/shell.nix
    /etc/nixos/modules/tmux.nix
    # ./modules/nvim.nix
  ];

  #Pkgs installed via os
  # steam, spotify, discord, i3, rofi, lutris, obs, obsidian
  home.packages = with pkgs; [
    # Utilities
    tldr
    htop
    screenkey
    neofetch
    jq
    tree
    fd
    ripgrep
    kubectl
    kubernetes-helm
    gh
    awscli2
    doppler
    ncdu
    nixpkgs-fmt
    stern
    glow
    dig
    wsl-open

    # languages
    nodejs_20
    jdk
    cargo
    nixd
  ];

}
