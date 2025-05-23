{
  pkgs,
  config,
  ...
}: let
  username = "mvaldes";
  homePath = "/home/${username}";
  unstable = import <nixos-unstable> {inherit pkgs;};
in {
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.05"; # Please read the comment before changing.
  home.enableNixpkgsReleaseCheck = false;
  home.file = {
    ".ssh/config" = {
      source = /home/${username}/git/dotfiles/.ssh/config;
    };
    ".local/bin" = {
      source = /home/${username}/git/dotfiles/scripts;
      recursive = true;
    };
    ".aws/config" = {
      source = /home/${username}/git/dotfiles/.aws/config;
    };
    ".config/wezterm" = {
      source = /home/${username}/git/dotfiles/.config/wezterm;
    };
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/mvaldes/git/dotfiles/.config/nvim";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    LC_ALL = "C.UTF-8";
    PATH = "$PATH:$HOME/.local/bin";
  };

  programs.home-manager.enable = true;
  programs.zsh.enable = true;

  imports = [
    "${homePath}/git/dotfiles-nix/modules/git.nix"
    "${homePath}/git/dotfiles-nix/modules/zsh.nix"
    "${homePath}/git/dotfiles-nix/modules/shell.nix"
    "${homePath}/git/dotfiles-nix/modules/tmux.nix"
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
    stern
    glow
    dig
    wsl-open

    # languages
    nodejs_22
    jdk
    cargo

    # lsp
    marksman
    ltex-ls
  ];
}
