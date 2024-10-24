{pkgs, ...}: {
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
    ".config/rofi" = {
      source = /home/mvaldes/git/dotfiles-nix/config/rofi;
      target = "/home/mvaldes/.config/rofi";
      executable = true;
    };
    ".config/i3" = {
      source = /home/mvaldes/git/dotfiles-nix/config/i3;
      target = "/home/mvaldes/.config/i3";
    };
    ".config/i3status-rust" = {
      source = /home/mvaldes/git/dotfiles-nix/config/i3status-rust;
      target = "/home/mvaldes/.config/i3status-rust";
    };
    ".config/wezterm" = {
      source = /home/mvaldes/git/dotfiles/.config/wezterm;
      target = "/home/mvaldes/.config/wezterm";
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
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/shell.nix
    ./modules/tmux.nix
    #./modules/nvim.nix
  ];

  #Pkgs installed via os
  # steam, spotify, discord, i3, rofi, lutris, obs, obsidian
  home.packages = with pkgs; [
    # Utilities
    tldr
    htop
    sox
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
    flameshot
    docker-compose
    dig
    feh
    bat
    wsl-open
  ];
}
