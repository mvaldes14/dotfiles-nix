{
  pkgs,
  config,
  ...
}: let
  username = "mvaldes";
in {
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.05";
  home.enableNixpkgsReleaseCheck = false;
  home.file = {
    ".ssh/config" = {
      source = /home/${username}/git/dotfiles/.ssh/config;
    };
    ".local/bin" = {
      source = /home/${username}/git/dotfiles/scripts;
      target = "/home/${username}/.local/bin";
      recursive = true;
    };
    ".aws/config" = {
      source = /home/${username}/git/dotfiles/.aws/config;
    };
    ".config/wezterm" = {
      source = /home/${username}/git/dotfiles/.config/wezterm;
      target = "/home/${username}/.config/wezterm";
    };
    ".config/waybar" = {
      source = /home/${username}/git/dotfiles-nix/config/waybar;
    };
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/git/dotfiles/.config/nvim";
    ".config/ghostty/config".source = /home/${username}/git/dotfiles/.config/ghostty/config;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    LC_ALL = "C.UTF-8";
    PATH = "$PATH:$HOME/.local/bin";
  };

  programs.home-manager.enable = true;
  programs.zsh.enable = true;

  imports = [
    /home/${username}/git/dotfiles-nix/modules/git.nix
    /home/${username}/git/dotfiles-nix/modules/zsh.nix
    /home/${username}/git/dotfiles-nix/modules/shell.nix
    /home/${username}/git/dotfiles-nix/modules/tmux.nix
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
    
    # languages
    nodejs_20
    jdk
    cargo

    # lsp
    marksman
    ltex-ls
  ];
}
