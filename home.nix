{ config, pkgs, ... }:

{
  home.username = "mvaldes";
  home.homeDirectory = "/home/mvaldes";
  home.stateVersion = "23.05"; # Please read the comment before changing.
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
      source = /home/mvaldes/.config/home-manager/config/rofi;
      target = "/home/mvaldes/.config/rofi";
    };
    ".config/i3" = {
      source = /home/mvaldes/.config/home-manager/config/i3;
      target = "/home/mvaldes/.config/i3";
    };
    ".config/i3status=rust" = {
      source = /home/mvaldes/.config/home-manager/config/i3status-rust;
      target = "/home/mvaldes/.config/i3status-rust";
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
    ./modules/nvim.nix
    ./modules/tmux.nix
    ./modules/wezterm.nix
  ];

  #Pkgs installed via os
  # steam, spotify, discord, i3, rofi, lutris, obs, obsidian
  home.packages = with pkgs; [
    neovim
    neofetch
    jq
    tree
    fd
    ripgrep
    kubectl
    kubernetes-helm
    k9s
    gh
    awscli2
    doppler
    ncdu
    arandr
    nixpkgs-fmt
    stern
    flameshot
    clipmenu
    #i3 apps
    light
    playerctl
    xclip
    feh
    pasystray
    dunst
    lxappearance
    i3status-rust
    pavucontrol
    picom
    # languages
    nodejs_20
    jdk20
  ];
}
